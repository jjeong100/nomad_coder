package org.rnt.production.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.MatRequireService;
import org.rnt.com.entity.service.MaterialOutService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionMstActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.WorkerService;
import org.rnt.com.entity.vo.MatRequireVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.net.Tcp;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.vo.ProductionComParamVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductionActController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @Resource(name="matRequireService")
    private MatRequireService matRequireService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="productionActService")
    private ProductionActService productionActService;
    
    @Resource(name="materialOutService")
    private MaterialOutService materialOutService;
    
    @Resource(name="workerService")
    private WorkerService workerService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name="productionMstActService")
    private ProductionMstActService productionMstActService;
    
    @RequestMapping(value = "/productionActListPage.do")
    public String productionActListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        search.setFactoryCd(proPertyService.getFactoryCd());
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
//            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMMdd"));
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // 제품
        //---------------------------------------------------------------------
        ProductVO product = new ProductVO();
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
            
            String userId = "";
            SessionData sData = SessionManager.getUserData(request);
            if (sData != null) {
                userId = sData.getUserId();
                model.addAttribute("userId", userId);
            }
        }
        
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_CALLDT");    
            search.setSortType("DESC");
        }
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (search.getPageSize() == 10) {
            search.setPageSize(3);
        }
        
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = productionOrderService.searchList(search);
        RtnVO rtnTotCnt = productionOrderService.searchListTotCnt(search);
        
        getCode("BAD_CD",model);
        getCode("PROD_TYPE_CD",model);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/production/productionActList";
    }
    
    @RequestMapping(value = "/getMatRequireListData.do")
    public ModelAndView getMatRequireListData(@ModelAttribute("matRequire")MatRequireVO matRequire, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = matRequireService.searchList(matRequire);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getProductionActListData.do")
    public ModelAndView getProductionActListData(@ModelAttribute("productionAct")ProductionActVO productionAct, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        if (StrUtil.isNull(productionAct.getSortCol())) {
             productionAct.setSortCol("EQUIP_NM");    
             productionAct.setSortType("ASC");
         }
         
        RtnVO rtn = productionActService.searchList(productionAct);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/productionActUpdateAct.do")
    public ModelAndView productionActUpdateAct(@ModelAttribute("productionAct")ProductionActVO productionAct, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = new RtnVO();
        
        ModelAndView mav = new ModelAndView("jsonView");
        productionAct.setFactoryCd(proPertyService.getFactoryCd());
        productionAct.setWriteId(getUserId(request));
        productionAct.setUpdateId(getUserId(request));
        
        //---------------------------------------------------------------------
        // 화면 setting 값 한번더 초기화
        //---------------------------------------------------------------------
        if (StrUtil.isNull(productionAct.getOperCd())) {
            productionAct.setOperCd(null);
        }
        if (StrUtil.isNull(productionAct.getBadCd())) {
            productionAct.setBadCd(null);
        }
        if (StrUtil.isNull(productionAct.getWorkactBigo())) {
            productionAct.setWorkactBigo(null);
        }
        
        //---------------------------------------------------------------------
        // Short ID Validation
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(productionAct.getShortId())) {
            WorkerVO worker = new WorkerVO();
            worker.setFactoryCd(proPertyService.getFactoryCd());
            worker.setShortId(productionAct.getShortId());
            RtnVO selRtn = workerService.selectByShortId(worker);
            if (selRtn.getObj() == null) {
                selRtn.setRc(GlvConst.RC_ERROR);
                selRtn.setMsg("존재하지 않은 숏 아이디 입니다.");
                wedEnd(request, selRtn, mav);
                return mav;
            } else {
                WorkerVO vo = (WorkerVO)selRtn.getObj();
                productionAct.setSabunId(vo.getSabunId());
            }
        }
        
        //-------------------------------------------------------------
        // 처리 Validation 
        //-------------------------------------------------------------
        if(isProductionOrderStatus(rtn,productionAct)) {
            if(proPertyService.getProductionOperCd().equals(productionAct.getOperCd())) {
                //-----------------------------------------------------------------
                // 생산
                //-----------------------------------------------------------------
                switch(productionAct.getProdTypeCd()) {
                case "ING":
                    productionActService.updatePlcProdSeq(productionAct);
                    log.info("SEND PLC CLEAR !!");

                    if(!"0:0:0:0:0:0:0:1".equals(getClientIp(request))) {
                        TcpConnection(productionActService.select(productionAct));
                    }
                    break; 
                case "END":
                    //-------------------------------------------------------------
                    // 생산 시작 : PLC 장비 초기화
                    //-------------------------------------------------------------
                    ProductionActVO updProdVo = new ProductionActVO();
//                    updProdVo.setEquipCd(productionAct.getEquipCd());
                    productionActService.updatePlcProdSeq(updProdVo);
                    log.info("SEND PLC CLEAR !!");

//                    System.out.println("■■■■■■ getClientIp -------------- : "+getClientIp(request));
                   if(!"0:0:0:0:0:0:0:1".equals(getClientIp(request))) {
                        TcpConnection(productionActService.select(productionAct));
                    }
                    break;
                    default:
                        break;
                }
            }
            
            rtn = productionActService.update(productionAct);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("지시 상태가 변경되어</br>재 조회후 사용하십시요.");
        }
        
        //-------------------------------------------------------------
        // 작업지시 종료 처리 : 모든 설비의 작업상태 종료 체크 후 작업지시 상태 종료 
        // -- 20210218 수정 최종 종료는 지시 배정 화면의 상태 변경값으로 한다.
        //-------------------------------------------------------------
        ProductionOrderStatus(productionAct, getUserId(request));
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    /**
     * -- ? 설비 종료시 end?
     * 작업지시 종료 처리 : 모든 설비의 작업상태 종료 체크 후 작업지시 상태 종료
     */
    public void ProductionOrderStatus(ProductionActVO productionAct,String UserId) {
    	productionAct.setProdTypeCd(null);
    	RtnVO rtnProductionActList = productionActService.searchList(productionAct);
    	if( rtnProductionActList.getObj() != null ) {
    		List<ProductionActVO> tempList = (List<ProductionActVO>) rtnProductionActList.getObj();
    		
    		boolean chkBool = true;
    		
    		for(ProductionActVO item : tempList) {
    			String prodTypeCd = item.getProdTypeCd();
    			// 생산지시상태코드:(WAT:대기,ING:작업중,END:완료,CAN:취소,STP:중지)
    			if( "WAT,ING,STP".indexOf(prodTypeCd) > -1 ) {
    				chkBool = false;
    				break;
    			}
    		}
    		
    		ProductionOrderVO upd = new ProductionOrderVO();
    		upd.setFactoryCd(proPertyService.getFactoryCd());
    		upd.setUpdateId(UserId);
    		upd.setProdSeq(productionAct.getProdSeq());
    		
    		// 대기, 작업중, 중지인 설비가 없을때만 작업지시 상태 완료.
    		if( chkBool ) {
    			upd.setProdTypeCd("END");
    		} else {
    			upd.setProdTypeCd("ING");
    		}
    		
    		// 작업지시 상태 변경
    		productionOrderService.update(upd);
    	}
    }
    
    /**
     * plc 연동
     * @param selRtn
     */
    public void TcpConnection(RtnVO selRtn) {
         try {
             ProductionActVO sel = (ProductionActVO)selRtn.getObj();
             Tcp tcp = new Tcp();
             tcp.setIp(proPertyService.getPlcIp());
             tcp.setPort(Integer.parseInt(proPertyService.getPlcPort()));
             tcp.setMsg(sel.getPlcClearMsg());
             tcp.tpConn();
             String rcvMsg = tcp.tpCall();
             log.info("rcv data:"+rcvMsg);
             tcp.close();
         } catch (Exception e) {log.info(e.getMessage());}
    }
    
    @RequestMapping(value = "/updateActbadQtyAct.do")
    public ModelAndView updateActbadQtyAct(@ModelAttribute("productionAct")ProductionActVO productionAct, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        ProductionActVO paramVo = new ProductionActVO();
        paramVo.setFactoryCd(proPertyService.getFactoryCd());
        paramVo.setWriteId(getUserId(request));
        paramVo.setUpdateId(getUserId(request));
        
        paramVo.setWorkactSeq(productionAct.getWorkactSeq());
        paramVo.setActokQty(productionAct.getActokQty());
        paramVo.setActbadQty(productionAct.getActbadQty());
//        paramVo.setActbadViewQty(productionAct.getActbadViewQty());
        
        RtnVO rtn = productionActService.update(paramVo);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
     /**
      * 20210218 지시상태가 종료(END),취소(CAN),중지(STP)는 생성,삭제가 안됩니다.
      *        - 지시 상태가 대기(WAT),작업중(ING) 상태는 생성,삭제가 됩니다. 
      * 
      * 20201123 jeonghwan
      * @param productionAct
      * @param request
      * @param model
      * @return
      * @throws Exception
      */
    @RequestMapping(value = "/productionActSaveAct.do")
    public ModelAndView productionActSaveAct(@ModelAttribute("productionAct")ProductionActVO productionAct, ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+productionAct.getCrudType());
        }
        
        productionAct.setFactoryCd(proPertyService.getFactoryCd());
        productionAct.setWriteId(getUserId(request));
        productionAct.setUpdateId(getUserId(request));
        
        /******************************************    작업수량 유효성 체크 [S]   ******************************************/
    	//-----------------------------------------------------------------
		// 유효성 체크 : 공정 마스터 배정수량을 초과한 작업수량은 오류
		//-----------------------------------------------------------------
    	ProductionMstActVO paramMstAct = new ProductionMstActVO();
    	paramMstAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramMstAct.setWriteId(getUserId(request));
    	paramMstAct.setUpdateId(getUserId(request));
    	paramMstAct.setWorkactMstSeq(prodComVo.getWorkactMstSeq());
    	RtnVO rtnMstVo = productionMstActService.select(paramMstAct);
    	ProductionMstActVO mstVo = (ProductionMstActVO) rtnMstVo.getObj();
    	
    	//-----------------------------------------------------------------
		// 실적 조회 : 현재 실적의 작업수량 조회
		//-----------------------------------------------------------------
    	ProductionActVO paramProductionAct = new ProductionActVO();
    	paramProductionAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramProductionAct.setWorkactSeq(prodComVo.getWorkactSeq());
    	RtnVO rtnProductionAct = productionActService.select(paramProductionAct);
    	ProductionActVO nowAct = (ProductionActVO) rtnProductionAct.getObj();
    	
    	// 작업수량이 수정된 경우 : 공정 마스터의 누적 작업수량에서 현실적의 작업수량을 뺀다.
    	if( nowAct != null ) {
			mstVo.setWorkQty( mstVo.getWorkQty() - nowAct.getPoQty() );
    	} else {
    		mstVo.setWorkQty( mstVo.getWorkQty() );
    	}
    	
    	System.out.println("■■■■■■■■■■■■■■■■ : "+mstVo.getLimitAssignQty());
    	System.out.println("■■■■■■■■■■■■■■■■ : "+mstVo.getWorkQty());
    	System.out.println("■■■■■■■■■■■■■■■■ : "+productionAct.getPoQty());
    	// 한도배정가능수량 보다 작업수량이 큰 경우 오류
    	if( mstVo.getLimitAssignQty() - mstVo.getWorkQty() < productionAct.getPoQty() ) {
    		rtnMstVo.setRc(GlvConst.RC_ERROR);
    		rtnMstVo.setMsg("작업수량이 배정수량을 초과하였습니다.");
    		wedEnd(request, rtnMstVo, mav);
    		return mav;
    	}
    	/******************************************    작업수량 유효성 체크 [E]   ******************************************/
        
    	//-----------------------------------------------------------------
		// 실적 추가 후 공정 마스터에 작업수량 업데이트 
		//-----------------------------------------------------------------
        if(isProductionOrderStatus(rtn,productionAct)) {
            if("C".equals(productionAct.getCrudType())) {
            	//실적 조회
                rtn = productionActService.select(productionAct);
                
                if(rtn.getObj() == null) { //지정 여부
                    productionAct.setWorkactSeq((String)productionActService.getSeq().getObj());
                    rtn = productionActService.insert(productionAct);
                } else {
                	ProductionActVO selProdAct = (ProductionActVO) rtn.getObj();
                	if ("N".equals(selProdAct.getUseYn())) {
                		rtn = productionActService.update(productionAct);
                	} else {
                		rtn.setRc(GlvConst.RC_ERROR);
                		rtn.setMsg("정보가 이미 등록되어 있습니다.");
                	}
                }
            } else if ("U".equals(productionAct.getCrudType())) {
                rtn = productionActService.update(productionAct);
            } else if("D".equals(productionAct.getCrudType())) {
                rtn = productionActService.deleteWat(productionAct);
            } else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("알수없는 저장 타입 :"+productionAct.getCrudType());
                wedEnd(request, rtn, mav);
                return mav;
            }
        }else{
              rtn.setRc(GlvConst.RC_ERROR);
              rtn.setMsg("지시 상태가 변경되어</br>재 조회후 사용하십시요.");
              wedEnd(request, rtn, mav);
              return mav;
        }
        
        //-----------------------------------------------------------------
		// 실적 추가 후 공정 마스터에 작업수량 업데이트 
		//-----------------------------------------------------------------
		productionAct.setSearchProdSeq(productionAct.getProdSeq());
		productionAct.setSearchOperCd(productionAct.getOperCd());
		productionAct.setProdTypeCd(productionAct.getProdTypeCd());
		RtnVO rtnActSum = productionActService.selectByProdAndOper(productionAct);    // 생산실적 합계 정보
		ProductionActVO sumQty = (ProductionActVO) rtnActSum.getObj();
		
		paramMstAct.setWorkQty(sumQty.getPoQty());
		paramMstAct.setActokQty(sumQty.getActokQty());
		paramMstAct.setActbadQty(sumQty.getActbadQty());
		rtn = productionMstActService.update(paramMstAct);
		
		if( rtn.getRc() < 0 ) {
			wedEnd(request, rtn, mav);
			return mav;
		}
		
		//-------------------------------------------------------------
		// 제품 작업지시 종료 처리 : MPO010 마지막 공정의 확정 건수 확인 후 제품작지 완료 처리
		//-------------------------------------------------------------
		paramMstAct.setProdSeq(prodComVo.getProdSeq());
		RtnVO rtnProdMstActList = productionMstActService.selectList(paramMstAct);
		if( rtnProdMstActList.getObj() != null ) {
			List<ProductionMstActVO> tempList = (List<ProductionMstActVO>) rtnProdMstActList.getObj();
			boolean chkBool = true;
			for(ProductionMstActVO item : tempList) {
				String workactTypeCd = item.getWorkactTypeCd();
				
				// 생산지시상태코드:(WAT:대기,ING:작업중,END:완료,CAN:취소,STP:중지)
				if( !"END".equals(workactTypeCd) ) {
					chkBool = false;
					break;
				}
			}
			
			ProductionOrderVO upd = new ProductionOrderVO();
			upd.setFactoryCd(proPertyService.getFactoryCd());
			upd.setUpdateId(getUserId(request));
			upd.setProdSeq(productionAct.getProdSeq());
			
			// 대기, 작업중, 중지인 설비가 없을때만 작업지시 상태 완료.
			if( chkBool ) {
				upd.setProdTypeCd("END");
			} else {
				upd.setProdTypeCd("ING");
			}
			
			// 작업지시 상태 변경
			productionOrderService.update(upd);
		}
		
		
		//-------------------------------------------------------------
		// 작업시작 처리시 MCC907 UPDATE
		//-------------------------------------------------------------
		if("ING".equals(productionAct.getProdTypeCd())) { //시작시
			productionActService.updatePlcEquipByProdSeq(productionAct);
		}
       
        wedEnd(request, rtn, model);
        return mav;
    }
    
    /**
     * 
     * @return
     */
    public boolean isProductionOrderStatus(RtnVO rtn, ProductionActVO productionAct) {
        boolean result = false;
        ProductionOrderVO productionOrder = new ProductionOrderVO();
        productionOrder.setFactoryCd(productionAct.getFactoryCd());
        productionOrder.setProdSeq(productionAct.getProdSeq());
        
         rtn = productionOrderService.select(productionOrder);
         ProductionOrderVO order = (ProductionOrderVO)rtn.getObj();
         
         if(rtn.getObj() != null) {
             productionAct.setSearchCondition(order.getSearchCondition());
             productionAct.setSearchKeyword(order.getSearchKeyword());
             productionAct.setSearchFromDate(order.getSearchFromDate());
             productionAct.setSearchToDate(order.getSearchToDate());
             
             Map<String,String> status = new HashMap<String,String>();
             status.put("END", "종료");
             status.put("CAN", "취소");
             status.put("STP", "중지");
             status.put("WAT", "대기");
             status.put("ING", "작업중");
             
             //-------------------------------------------------------------
             // 처리 Validation 
             //-------------------------------------------------------------
             switch(order.getProdTypeCd()) {
             case "WAT":
             case "ING":
                 result = true;
                 break;
             case "END":
             case "CAN":
             case "STP":
             default:
                 result = false;
                 break;
             }
         }
        
        return result;
    }
    
    @RequestMapping(value = "/productionActTackOverSaveAct.do")
    public ModelAndView productionActTackOverSaveAct(@ModelAttribute("productionAct")ProductionActVO productionAct, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = new RtnVO();
        
        ModelAndView mav = new ModelAndView("jsonView");
        productionAct.setFactoryCd(proPertyService.getFactoryCd());
        productionAct.setWriteId(getUserId(request));
        productionAct.setUpdateId(getUserId(request));
        
        //---------------------------------------------------------------------
        // Short ID Validation
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(productionAct.getShortId())) {
            WorkerVO worker = new WorkerVO();
            worker.setFactoryCd(proPertyService.getFactoryCd());
            worker.setShortId(productionAct.getShortId());
            RtnVO selRtn = workerService.selectByShortId(worker);
            if (selRtn.getObj() == null) {
                selRtn.setRc(GlvConst.RC_ERROR);
                selRtn.setMsg("존재하지 않은 숏 아이디 입니다.");
                wedEnd(request, selRtn, mav);
                return mav;
            } else {
                WorkerVO vo = (WorkerVO)selRtn.getObj();
                productionAct.setSabunId(vo.getSabunId());
            }
        }
        
        //실적 조회
        rtn = productionActService.select(productionAct);
        ProductionActVO selProductionActVo = (ProductionActVO) rtn.getObj();
        
        if( productionAct.getSabunId().equals(selProductionActVo.getSabunId())) {
        	rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("동일한 작업자에게 배정(이어받기) 할 수 없습니다.");
            wedEnd(request, rtn, mav);
            return mav;
        }
        
        // 남은 배정수량
        //int remainQty = selProductionActVo.getEquipQty() - (selProductionActVo.getActokQty() + selProductionActVo.getActbadQty());
        int remainQty = selProductionActVo.getPoQty();
        
        //실적 작업종료
        selProductionActVo.setProdTypeCd("END");
        selProductionActVo.setWorkedDt(DateUtil.formatCurrentDateTime());
        selProductionActVo.setActokQty(productionAct.getActokQty());
        selProductionActVo.setActbadQty(productionAct.getActbadQty());
//        selProductionActVo.setEquipQty(selProductionActVo.getActokQty() + selProductionActVo.getActbadQty());
        productionActService.update(selProductionActVo);
        
        // 이전배정수량 - 현재배정수량(작업종료시 전달받은 양품수량 + 불량수량)
//        remainQty = remainQty - selProductionActVo.getEquipQty();
        
        // 실적추가
        ProductionActVO insertRow = new ProductionActVO(); 
        insertRow.setFactoryCd(proPertyService.getFactoryCd());
        insertRow.setWriteId(getUserId(request));
        insertRow.setUpdateId(getUserId(request));
        insertRow.setProdSeq(productionAct.getProdSeq());
        insertRow.setWorkactSeq((String) productionActService.getSeq().getObj());
        insertRow.setOperCd(selProductionActVo.getOperCd());
        insertRow.setOperSeq(selProductionActVo.getOperSeq());
        insertRow.setItemCd(selProductionActVo.getItemCd());
        insertRow.setBomVer(selProductionActVo.getBomVer());
        insertRow.setBomStdt(selProductionActVo.getBomStdt());
        insertRow.setPoQty(selProductionActVo.getPoQty());
//        insertRow.setEquipQty(remainQty);
        insertRow.setSabunId(productionAct.getSabunId());
        insertRow.setProdTypeCd("ING");
        insertRow.setWorkDt(productionAct.getWorkDt());
        insertRow.setWorkstDt(productionAct.getWorkstDt());
        
        rtn = productionActService.insert(insertRow);
        
        // SEND PLC CLEAR !!
        if(!"0:0:0:0:0:0:0:1".equals(getClientIp(request))) {
            TcpConnection(productionActService.select(productionAct));
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/productionActConfirmSaveAct.do")
    public ModelAndView productionActConfirmSaveAct(ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = new RtnVO();
    	
    	//-----------------------------------------------------------------
		// 공정 마스터 조회 
		//-----------------------------------------------------------------
    	ProductionMstActVO paramProductionMstAct = new ProductionMstActVO();
    	paramProductionMstAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramProductionMstAct.setWorkactMstSeq(prodComVo.getWorkactMstSeq());
    	RtnVO rtnMstVo = productionMstActService.select(paramProductionMstAct);
    	ProductionMstActVO selMstVo = (ProductionMstActVO) rtnMstVo.getObj();
    	
    	//-----------------------------------------------------------------
		// 실적 조회 
		//-----------------------------------------------------------------
    	ProductionActVO paramProductionAct = new ProductionActVO();
    	paramProductionAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramProductionAct.setUpdateId(getUserId(request));
    	paramProductionAct.setWorkactSeq(prodComVo.getWorkactSeq());
    	RtnVO rtnProductionAct = productionActService.select(paramProductionAct);
    	ProductionActVO selProductionAct = (ProductionActVO) rtnProductionAct.getObj();
    	
    	//-----------------------------------------------------------------
		// 실적 확정
		//-----------------------------------------------------------------
    	paramProductionAct.setConfirmYn("Y");
    	rtn = productionActService.update(paramProductionAct);
    	
    	if( rtn.getRc() < 0 ) {
    		wedEnd(request, rtn, mav);
            return mav;
    	}
    	
    	//-----------------------------------------------------------------
		// 확정수량조회
		//-----------------------------------------------------------------
    	paramProductionAct.setSearchProdSeq(prodComVo.getProdSeq());
    	paramProductionAct.setSearchOperCd(prodComVo.getOperCd());
    	RtnVO rtnActSum = productionActService.selectByProdAndOper(paramProductionAct);    // 생산실적 합계 정보
    	ProductionActVO sumQty = (ProductionActVO) rtnActSum.getObj();
    	
    	//-----------------------------------------------------------------
		// 공정 마스터에 확정수량 업데이트 
		//-----------------------------------------------------------------
    	ProductionMstActVO paramMstAct = new ProductionMstActVO();
    	paramMstAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramMstAct.setUpdateId(getUserId(request));
    	paramMstAct.setWorkactMstSeq(prodComVo.getWorkactMstSeq());
    	paramMstAct.setConfirmQty( sumQty.getActokQty() );
    	
    	rtn = productionMstActService.update(paramMstAct);
    	
    	if( rtn.getRc() < 0 ) {
    		wedEnd(request, rtn, mav);
            return mav;
    	}
    	
    	//-----------------------------------------------------------------
		// 다음공정 배정수량 업데이트, 확정은 실적당 한번만 가능.
		//-----------------------------------------------------------------
		int nextOPerLvl = selMstVo.getOperLvl() + 1;
		ProductionMstActVO nextMstActVo = new ProductionMstActVO();
		nextMstActVo.setFactoryCd(proPertyService.getFactoryCd());
		nextMstActVo.setUpdateId(getUserId(request));
		nextMstActVo.setProdSeq(prodComVo.getProdSeq());
		nextMstActVo.setOperLvl(nextOPerLvl);
		nextMstActVo.setAssignQty(sumQty.getActokQty());
		
		productionMstActService.updateAssignQty(nextMstActVo);
		
		//-------------------------------------------------------------
		// 제품 작업지시 종료 처리 : MPO010 마지막 공정의 확정 건수 확인 후 제품작지 완료 처리
		//-------------------------------------------------------------
    	paramMstAct.setProdSeq(prodComVo.getProdSeq());
    	RtnVO rtnProdMstActList = productionMstActService.selectList(paramMstAct);
    	if( rtnProdMstActList.getObj() != null ) {
    		List<ProductionMstActVO> tempList = (List<ProductionMstActVO>) rtnProdMstActList.getObj();
    		
    		boolean chkBool = true;
    		for(ProductionMstActVO item : tempList) {
    			String workactTypeCd = item.getWorkactTypeCd();
    			
    			// 생산지시상태코드:(WAT:대기,ING:작업중,END:완료,CAN:취소,STP:중지)
    			if( !"END".equals(workactTypeCd) ) {
    				chkBool = false;
    				break;
    			}
			}
    		
    		ProductionOrderVO upd = new ProductionOrderVO();
			upd.setFactoryCd(proPertyService.getFactoryCd());
			upd.setUpdateId(getUserId(request));
			upd.setProdSeq(prodComVo.getProdSeq());
			
    		// 대기, 작업중, 중지인 설비가 없을때만 작업지시 상태 완료.
    		if( chkBool ) {
    			upd.setProdTypeCd("END");
    		} else {
    			upd.setProdTypeCd("ING");
    		}
    		
    		// 작업지시 상태 변경
    		productionOrderService.update(upd);
    	}
    	
    	wedEnd(request, rtn, mav);
        return mav;
    }
    	
}
