package org.rnt.api.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.BomService;
import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.FileUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.FileVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;

@Controller
public class BomListApiController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name = "fileUtil")
    FileUtil fileUtil;
    
    @Resource(name="bomService")
    private BomService bomService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/bomListApiPage.do")
    public String bomListApiPage(@ModelAttribute("search")BomVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/api/bomListApi";
    }
    
    @RequestMapping(value = "/bomListGetApi.do")
    public String bomListGetApi(@ModelAttribute("search")BomVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("ITEM_CD, BOM_LEVEL");    
            search.setSortType("ASC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = bomService.searchList(search);
        RtnVO rtnTotCnt = bomService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        search.setCrudType("GET");
        wedEnd(request, rtn, model);
        return "/api/bomListApi";
    }
    
    @RequestMapping(value = "/bomListSetApiExcel.do")
    public ModelAndView bomListSetApiExcel(@ModelAttribute("search")FileVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        List<ComFileVO> fileList = fileUtil.saveFile(request);
        ComFileVO file = fileList.get(0);
        mav.addObject("file", file);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
    @RequestMapping(value = "/bomListGetApiExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void bomListGetApiExcel(@ModelAttribute("search")BomVO search, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, WriteException {
        String folderName = req.getSession().getServletContext().getRealPath("excelTemp");
        String realFileName = "temp"+UUID.randomUUID()+".xls";
        String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
        
        File folder = new File(folderName);
        if (!folder.exists()) {
            folder.mkdir();
        }
        File file = new File(folder, realFileName);
        WritableWorkbook workbook = null;
        WritableSheet sheet = null;
        workbook = Workbook.createWorkbook(file);
        sheet = workbook.createSheet("Sheet", 0);
        
        WritableCellFormat titleFormat  = new WritableCellFormat(
            new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
                                10,                             //폰트 크기 
                                WritableFont.BOLD,              //Bold 스타일
                                false,                          //이탤릭체여부
                                UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
                                Colour.WHITE,                   //폰트 색
                                ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
        );
        
        titleFormat.setAlignment(Alignment.CENTRE);
        titleFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
        titleFormat.setBackground(Colour.GRAY_50);
        WritableCellFormat bodyFormat  = new WritableCellFormat(
                new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
                                    10,                             //폰트 크기 
                                    WritableFont.NO_BOLD,           //Bold 스타일
                                    false,                          //이탤릭체여부
                                    UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
                                    Colour.BLACK,                   //폰트 색
                                    ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
            );
        bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
        
        
        //---------------------------------------------------------------------
        // head
        //---------------------------------------------------------------------
        sheet.addCell(new Label(0, 0, "No", titleFormat));
        sheet.addCell(new Label(1, 0, "제품명", titleFormat));
        sheet.addCell(new Label(2, 0, "공정순번", titleFormat));
        sheet.addCell(new Label(3, 0, "공정코드", titleFormat));
        sheet.addCell(new Label(4, 0, "공정명", titleFormat));
        sheet.addCell(new Label(5, 0, "상위공정순번", titleFormat));
        
        //---------------------------------------------------------------------
        // data
        //---------------------------------------------------------------------
        RtnVO rtn = bomService.searchList(search);
        if (rtn.getObj() != null) {
            List<BomVO> list = (List<BomVO>)rtn.getObj();
            for(int i=0; i<list.size(); i++) {
                BomVO vo = list.get(i);
                sheet.addCell(new Label(0, i+1, vo.getRnum().toString(), bodyFormat));
                sheet.addCell(new Label(1, i+1, vo.getItemNm(), bodyFormat));
                sheet.addCell(new Label(2, i+1, vo.getOperSeq(), bodyFormat));
                sheet.addCell(new Label(3, i+1, vo.getOperCd(), bodyFormat));
                sheet.addCell(new Label(4, i+1, vo.getOperNm(), bodyFormat));
                sheet.addCell(new Label(5, i+1, vo.getOperUpcdSeq(), bodyFormat));
            }
        }

        workbook.write();
        workbook.close();

        JsonObject resultJson = new JsonObject();
        resultJson.addProperty("folderName", folderName);
        resultJson.addProperty("realFileName", realFileName);
        resultJson.addProperty("saveFileName", saveFileName);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(resultJson.toString());
        
    }
    
}
