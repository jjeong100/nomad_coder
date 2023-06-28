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
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.FileUtil;
import org.rnt.com.util.StrUtil;
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
public class ApiController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name = "fileUtil")
    FileUtil fileUtil;
    
    @Resource(name="companyService")
    private CompanyService companyService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/companyApiPage.do")
    public String companyApiPage(@ModelAttribute("search")CompanyVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/api/companyApi";
    }
    
    @RequestMapping(value = "/companyGetApi.do")
    public String companyGetApi(@ModelAttribute("search")CompanyVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = companyService.searchList(search);
        RtnVO rtnTotCnt = companyService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        search.setCrudType("GET");
        wedEnd(request, rtn, model);
        return "/api/companyApi";
    }
    
    
//    @RequestMapping(value = "/companySetApiExcel.do")
//    public ModelAndView companySetApiExcel(@ModelAttribute("search")FileVO search, HttpServletRequest request, ModelMap model)  throws Exception {
//    	webStart(request);
//    	ModelAndView mav = new ModelAndView("jsonView");
//    	RtnVO rtn = new RtnVO();
//    	List<FileVO> fileList = fileUtil.saveFile(request, proPertyService);
//    	FileVO file = fileList.get(0);
//    	mav.addObject("file", file);
//    	wedEnd(request, rtn, mav);
//    	return mav;
//    }
    
    /**
     * @param paramData
     * @param request
     * @param model
     * @throws Exception
     */
    @RequestMapping(value = "/companySetApiExcel.do", method = RequestMethod.POST)
    public ModelAndView companySetApiExcel(@RequestBody String paramData, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        String temp = URLDecoder.decode(paramData, "UTF-8");
        temp = temp.replaceAll("=", "");	// json 문자열 뒤에 '='문자가 붙어와서 제거함.

        List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
        resultMap = JSONArray.fromObject(temp);
        
        for (Map<String, Object> map : resultMap ) {
        	CompanyVO obj = new CompanyVO();
        	
        	obj.setFactoryCd(proPertyService.getFactoryCd());
        	obj.setWriteId(getUserId(request));
        	obj.setUpdateId(getUserId(request));
        	obj.setCustCd((String) map.get("custCd"));
        	obj.setCustNm((String) map.get("custNm"));
        	obj.setCustTypeCd((String) map.get("custTypeCd"));
        	obj.setMatTypeCd((String) map.get("matTypeCd"));
        	obj.setTelNo((String) map.get("telNo"));
        	obj.setFaxNo((String) map.get("faxNo"));
        	obj.setPresidenNm((String) map.get("presidenNm"));
        	obj.setPersonTel((String) map.get("personTel"));
        	obj.setPersonTel((String) map.get("personTel"));
        	obj.setPersonEmail((String) map.get("personEmail"));
        	obj.setUseYn((String) map.get("useYn"));
        	
        	rtn = companyService.select(obj);
            if(rtn.getObj() == null) {
                rtn = companyService.insert(obj);
            } else {
                CompanyVO company = (CompanyVO)rtn.getObj();
                if ("N".equals(company.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = companyService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
    @RequestMapping(value = "/companyGetApiExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void companyGetApiExcel(@ModelAttribute("search")CompanyVO search, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, WriteException {
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
        sheet.addCell(new Label(1, 0, "코드", titleFormat));
        sheet.addCell(new Label(2, 0, "거래처명", titleFormat));
        sheet.addCell(new Label(3, 0, "업체구분", titleFormat));
        sheet.addCell(new Label(4, 0, "자재구분", titleFormat));
        sheet.addCell(new Label(5, 0, "TEL", titleFormat));
        sheet.addCell(new Label(6, 0, "FAX", titleFormat));
        sheet.addCell(new Label(7, 0, "대표자", titleFormat));
        sheet.addCell(new Label(8, 0, "담당자명", titleFormat));
        sheet.addCell(new Label(9, 0, "당당자TEL", titleFormat));
        sheet.addCell(new Label(10, 0, "EMAIL", titleFormat));
        
        //---------------------------------------------------------------------
        // data
        //---------------------------------------------------------------------
        RtnVO rtn = companyService.searchList(search);
        if (rtn.getObj() != null) {
            List<CompanyVO> list = (List<CompanyVO>)rtn.getObj();
            for(int i=0; i<list.size(); i++) {
                CompanyVO vo = list.get(i);
                sheet.addCell(new Label(0, i+1, vo.getRnum().toString(), bodyFormat));
                sheet.addCell(new Label(1, i+1, vo.getCustCd(), bodyFormat));
                sheet.addCell(new Label(2, i+1, vo.getCustNm(), bodyFormat));
                sheet.addCell(new Label(3, i+1, vo.getCustTypeNm(), bodyFormat));
                sheet.addCell(new Label(4, i+1, vo.getMatTypeNm(), bodyFormat));
                sheet.addCell(new Label(5, i+1, vo.getTelNo(), bodyFormat));
                sheet.addCell(new Label(6, i+1, vo.getFaxNo(), bodyFormat));
                sheet.addCell(new Label(7, i+1, vo.getPresidenNm(), bodyFormat));
                sheet.addCell(new Label(8, i+1, vo.getPersonNm(), bodyFormat));
                sheet.addCell(new Label(9, i+1, vo.getPersonTel(), bodyFormat));
                sheet.addCell(new Label(10, i+1, vo.getPersonEmail(), bodyFormat));
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
