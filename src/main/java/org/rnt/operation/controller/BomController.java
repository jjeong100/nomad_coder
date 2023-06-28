package org.rnt.operation.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.rnt.com.entity.service.BomHistoryService;
import org.rnt.com.entity.service.BomInspSecService;
import org.rnt.com.entity.service.BomInspService;
import org.rnt.com.entity.service.BomService;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.OperationService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.vo.BomHistoryVO;
import org.rnt.com.entity.vo.BomInspSecVO;
import org.rnt.com.entity.vo.BomInspVO;
import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.OperationVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.operation.service.OperationMenuService;
import org.rnt.operation.vo.BomTreeInVO;
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
public class BomController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="operationMenuService")
    private OperationMenuService operationMenuService;
    
    @Resource(name="bomService")
    private BomService bomService;
    
    @Resource(name="bomInspService")
    private BomInspService bomInspService;
    
    @Resource(name="bomInspSecService")
    private BomInspSecService bomInspSecService;
    
    @Resource(name="bomHistoryService")
    private BomHistoryService bomHistoryService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="operationService")
    private OperationService operationService;
    
    @Resource(name="materialService")
    private MaterialService materialService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/bomTreeListPage.do")
    public String bomTreeListPage(@ModelAttribute("search")BomTreeInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        
        ProductVO product = new ProductVO();
        /*
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
        }
        */
        
        return "/operation/bomTreeList";
    }
    @RequestMapping(value = "/bomGetApiExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void userGetApiExcel(@ModelAttribute("searchBomForm")BomVO search, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, WriteException {
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
        sheet.addCell(new Label(2, 0, "공정명", titleFormat));
        sheet.addCell(new Label(3, 0, "자재명", titleFormat));
        sheet.addCell(new Label(4, 0, "구분", titleFormat));
        sheet.addCell(new Label(5, 0, "소요량", titleFormat));
     //   sheet.addCell(new Label(6, 0, "Reference", titleFormat));
        
        //---------------------------------------------------------------------
        // data
        //---------------------------------------------------------------------
        search.setSearchItemCd(null);
        search.setSearchOperSeq(null);
        search.setSearchBomTypeCd(null);
        search.setSortCol("ITEM_CD ASC , A.BOM_LEVEL ASC, A.MAT_CD");
        search.setSortType("ASC");
        RtnVO rtn = bomService.searchList(search);
        if (rtn.getObj() != null) {
            List<BomVO> list = (List<BomVO>)rtn.getObj();
            for(int i=0; i<list.size(); i++) {
            	BomVO vo = list.get(i);
                sheet.addCell(new Label(0, i+1, vo.getRnum().toString(), bodyFormat));
                sheet.addCell(new Label(1, i+1, vo.getItemNm(), bodyFormat));
                sheet.addCell(new Label(2, i+1, vo.getOperNm(), bodyFormat));
                sheet.addCell(new Label(3, i+1, vo.getMatNm(), bodyFormat));
                sheet.addCell(new Label(4, i+1, vo.getMatTypeNm(), bodyFormat));
                sheet.addCell(new Label(5, i+1, (String.valueOf(vo.getDemandQty()).equals("null") ? "" : String.valueOf(vo.getDemandQty())), bodyFormat));
               // sheet.addCell(new Label(6, i+1, vo.getJikCd(), bodyFormat));
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
    
    @RequestMapping(value = "/getBomTreeData.do")
    public ModelAndView getBomTreeData(@ModelAttribute("search")BomTreeInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        Map<String, Object> map = new HashMap<String, Object>();
        RtnVO rtn = operationMenuService.searchBomTreeList(search);
        map.put("treeData", rtn.getObj());
        mav.addAllObjects(map);
        return mav;
    }
    
    @RequestMapping(value = "/getOperationListData.do")
    public ModelAndView getOperationListData(@ModelAttribute("operation")OperationVO operation, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        operation.setBomNotInYn("Y");
        RtnVO rtn = operationService.searchList(operation);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getMatListData.do")
    public ModelAndView getMatListData(@ModelAttribute("search")MaterialVO mat, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = materialService.searchPopBomMatList(mat);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getItemListData.do")
    public ModelAndView getItemListData(@ModelAttribute("search")ProductVO param, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = productService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/bomCreateAct.do")
    public ModelAndView bomCreateAct(@ModelAttribute("bom")BomVO bom, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        bom.setFactoryCd(proPertyService.getFactoryCd());
        bom.setWriteId(getUserId(request));
        bom.setUpdateId(getUserId(request));
        if (log.isDebugEnabled()) {
            log.debug("getItemCd:"+bom.getItemCd());
            log.debug("getOperSeq:"+bom.getOperSeq());
            log.debug("getOperUpcdSeq:"+bom.getOperUpcdSeq());
        }
        
        // 상위가 없는 경우
        if (StrUtil.isNull(bom.getOperUpcdSeq())) {
        	RtnVO selBomRtn = bomService.selectByItemCdAndOperSeq(bom);
        	if (selBomRtn.getRc() == GlvConst.RC_SUCC) {
        		if (selBomRtn.getObj() != null) {
        			BomVO selBom = (BomVO)selBomRtn.getObj();
        			if (!StrUtil.isNull(selBom.getOperUpcdSeq())) {
        				bom.setOperUpcdSeq(selBom.getOperUpcdSeq());
        			}
        		}
        	}
        }
        
        RtnVO rtn = bomService.insert(bom);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/deleteBomTree.do")
    public ModelAndView deleteBomTree(@ModelAttribute("bom")BomVO bom, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        if (log.isDebugEnabled()) {
            log.debug("getItemCd:"+bom.getItemCd());
        }
        
        RtnVO rtn = operationMenuService.deleteBomTree(bom);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/deleteBomMat.do")
    public ModelAndView deleteBomMat(@ModelAttribute("bom")BomVO bom, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        if (log.isDebugEnabled()) {
            log.debug("getItemCd:"+bom.getItemCd());
        }
        bom.setFactoryCd(proPertyService.getFactoryCd());
        
        RtnVO rtn = bomService.delete(bom);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/deleteBomInspItem.do")
    public ModelAndView deleteBomInspItem(@ModelAttribute("bomInsp")BomInspVO bomInsp, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        bomInsp.setFactoryCd(proPertyService.getFactoryCd());
        
        RtnVO rtn = bomInspService.delete(bomInsp);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
    @RequestMapping(value = "/saveBomInspItem.do")
    public ModelAndView saveBomInspItem(@ModelAttribute("bomInsp")BomInspVO bomInsp, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        bomInsp.setFactoryCd(proPertyService.getFactoryCd());
        
        RtnVO rtn = bomInspService.update(bomInsp);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/bomListData.do")
    public ModelAndView bomListData(@ModelAttribute("searchBom")BomVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = bomService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/bomInspItemListData.do")
    public ModelAndView bomInspItemListData(@ModelAttribute("search")BomInspVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = bomInspService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/confirmBomAct.do")
    public ModelAndView bomOperationListData(@ModelAttribute("bom")BomVO bom, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	bom.setFactoryCd(proPertyService.getFactoryCd());
        bom.setWriteId(getUserId(request));
        bom.setUpdateId(getUserId(request));
        RtnVO rtn = operationMenuService.confirmBom(bom);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/bomHistoryListData.do")
    public ModelAndView bomHistoryListData(@ModelAttribute("searchBomHistory")BomHistoryVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = bomHistoryService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
    @RequestMapping(value = "/bomInspItemCreateAct.do")
    public ModelAndView bomInspItemCreateAct(@ModelAttribute("obj")BomInspVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        BomVO bom = new BomVO();
        bom.setFactoryCd(proPertyService.getFactoryCd());
        bom.setItemCd(obj.getSearchItemCd());
        bom.setOperSeq(obj.getSearchOperSeq());
        RtnVO selBomRtn = bomService.selectByItemCdAndOperSeq(bom);
        BomVO vo = (BomVO)selBomRtn.getObj();
        obj.setBomSeq(vo.getBomSeq());
        
        RtnVO rtn = bomInspService.insert(obj);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/bomInspSecListData.do")
    public ModelAndView bomInspSecListData(@ModelAttribute("searchInspSec") BomInspSecVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	BomVO bom = new BomVO();
        bom.setFactoryCd(proPertyService.getFactoryCd());
        bom.setItemCd(obj.getSearchItemCd());
        bom.setOperSeq(obj.getSearchOperSeq());
        RtnVO selBomRtn = bomService.selectByItemCdAndOperSeq(bom);
        BomVO vo = (BomVO)selBomRtn.getObj();
        
    	obj.setFactoryCd(proPertyService.getFactoryCd());
    	obj.setBomSeq(vo.getBomSeq());
        RtnVO rtn = bomInspSecService.searchList(obj);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/saveBomInspSec.do")
    public ModelAndView saveBomInspSec(@ModelAttribute("obj")BomInspSecVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        obj.setFactoryCd(proPertyService.getFactoryCd());
        
        RtnVO rtn = new RtnVO();
        
        List<BomInspSecVO> objList = (List<BomInspSecVO>) obj.getObjList();
        
		for (BomInspSecVO tempVo : objList) {
			tempVo.setFactoryCd(proPertyService.getFactoryCd());
			tempVo.setBomSeq(obj.getBomSeq());
			tempVo.setWriteId(getUserId(request));
			tempVo.setUpdateId(getUserId(request));
			
			if( "".equals(tempVo.getBomSecSeq()) ) {
				rtn = bomInspSecService.insert(tempVo);
			} else {
				rtn = bomInspSecService.update(tempVo);
			}
		}
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/delBomInspSec.do")
    public ModelAndView delBomInspSec(@ModelAttribute("obj")BomInspSecVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	obj.setFactoryCd(proPertyService.getFactoryCd());
    	RtnVO rtn = bomInspSecService.delete(obj);
    	wedEnd(request, rtn, mav);
    	return mav;
    }
}
