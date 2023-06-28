package org.rnt.api.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.FileUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.FileVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
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

@Controller
public class EquipApiController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name = "fileUtil")
    FileUtil fileUtil;
    
    @Resource(name="equipService")
    private EquipService equipService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/equipApiPage.do")
    public String equipApiPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/api/equipApi";
    }
    @RequestMapping(value = "/equipTypeApiPage.do")
    public String equipTypeApiPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webViewLog(request);
    	return "/api/equipTypeApi";
    }
    
    @RequestMapping(value = "/equipGetApi.do")
    public String equipGetApi(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = equipService.searchList(search);
        RtnVO rtnTotCnt = equipService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        search.setCrudType("GET");
        wedEnd(request, rtn, model);
        return "/api/equipApi";
    }
    
    @RequestMapping(value = "/equipTypeGetApi.do")
    public String equipTypeGetApi(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	if (StrUtil.isNull(search.getSortCol())) {
    		search.setSortCol("UPDATE_DT");    
    		search.setSortType("DESC");
    	}
    	search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
    	RtnVO rtn = equipService.searchList(search);
    	RtnVO rtnTotCnt = equipService.searchListTotCnt(search);
    	rtn.setTotCnt((Integer)rtnTotCnt.getObj());
    	search.setCrudType("GET");
    	wedEnd(request, rtn, model);
    	return "/api/equipTypeApi";
    }
    
    
    @RequestMapping(value = "/equipSetApiExcel.do")
    public ModelAndView equipSetApiExcel(@ModelAttribute("search")FileVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        List<ComFileVO> fileList = fileUtil.saveFile(request);
        ComFileVO file = fileList.get(0);
        mav.addObject("file", file);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
    @RequestMapping(value = "/equipGetApiExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void equipGetApiExcel(@ModelAttribute("search")EquipVO search, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, WriteException {
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
        sheet.addCell(new Label(1, 0, "설비코드", titleFormat));
        sheet.addCell(new Label(2, 0, "장비코드", titleFormat));
        sheet.addCell(new Label(3, 0, "프로그램", titleFormat));
        sheet.addCell(new Label(4, 0, "장비모델번호", titleFormat));
        sheet.addCell(new Label(5, 0, "제조사", titleFormat));
        sheet.addCell(new Label(6, 0, "구입일자", titleFormat));
        sheet.addCell(new Label(7, 0, "설비IP", titleFormat));
        
        //---------------------------------------------------------------------
        // data
        //---------------------------------------------------------------------
        RtnVO rtn = equipService.searchList(search);
        if (rtn.getObj() != null) {
            List<EquipVO> list = (List<EquipVO>)rtn.getObj();
            for(int i=0; i<list.size(); i++) {
                EquipVO vo = list.get(i);
                sheet.addCell(new Label(0, i+1, vo.getRnum().toString(), bodyFormat));
                sheet.addCell(new Label(1, i+1, vo.getEquipCd(), bodyFormat));
                sheet.addCell(new Label(2, i+1, vo.getEquipNm(), bodyFormat));
                sheet.addCell(new Label(3, i+1, vo.getEquipPg(), bodyFormat));
                sheet.addCell(new Label(4, i+1, vo.getEquipModelNo(), bodyFormat));
                sheet.addCell(new Label(5, i+1, vo.getEquipCorpNm(), bodyFormat));
                sheet.addCell(new Label(6, i+1, vo.getEquipGetDt(), bodyFormat));
                sheet.addCell(new Label(7, i+1, vo.getEquipIp(), bodyFormat));
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
    
    @RequestMapping(value = "/equipTypeGetApiExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void equipTypeGetApiExcel(@ModelAttribute("search")EquipVO search, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, WriteException {
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
    	sheet.addCell(new Label(1, 0, "설비코드", titleFormat));
    	sheet.addCell(new Label(2, 0, "설비명", titleFormat));
    	sheet.addCell(new Label(3, 0, "설비유형", titleFormat));
    	sheet.addCell(new Label(4, 0, "제조사", titleFormat));
    	sheet.addCell(new Label(5, 0, "구입일자", titleFormat));
    	
    	//---------------------------------------------------------------------
    	// data
    	//---------------------------------------------------------------------
    	RtnVO rtn = equipService.searchList(search);
    	if (rtn.getObj() != null) {
    		List<EquipVO> list = (List<EquipVO>)rtn.getObj();
    		for(int i=0; i<list.size(); i++) {
    			EquipVO vo = list.get(i);
    			sheet.addCell(new Label(0, i+1, vo.getRnum().toString(), bodyFormat));
    			sheet.addCell(new Label(1, i+1, vo.getEquipCd(), bodyFormat));
    			sheet.addCell(new Label(2, i+1, vo.getEquipNm(), bodyFormat));
    			sheet.addCell(new Label(3, i+1, vo.getEquipTypeNm(), bodyFormat));
    			sheet.addCell(new Label(4, i+1, vo.getEquipCorpNm(), bodyFormat));
    			sheet.addCell(new Label(5, i+1, vo.getEquipGetDt(), bodyFormat));
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
