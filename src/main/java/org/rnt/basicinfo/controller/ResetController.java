package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ResetService;
import org.rnt.com.entity.vo.ResetVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ResetController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="resetService")
    private ResetService resetService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/reset.do")
    public String resetListPage(@ModelAttribute("search")ResetVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
//        RtnVO rtn = resetService.searchList(search);
        RtnVO rtn = new RtnVO();

        wedEnd(request, rtn, model);

        SessionData sessionData = SessionManager.getUserData();
        if(sessionData == null || sessionData.getUserId() == null || "".equals(sessionData.getUserId()) || !"ADMIN".equals(sessionData.getUserId().toUpperCase())) return "/basicinfo/login";
        else return "/basicinfo/resetList";
    }


    /**
     * -  클린
     * @param param
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteCleanAct.do")
    public ModelAndView deleteCleanAct(@ModelAttribute("obj")ResetVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        switch(param.getDeleteType()) {
        case "deleteMaterial"://1
            this.deleteFunction(param, "MMA022");
            this.deleteFunction(param, "MMA024");
            this.deleteFunction(param, "MWP001");
            this.deleteFunction(param, "MWP005");
            this.deleteFunction(param, "MMA025");
            this.deleteFunction(param, "MMA026");
            break;
        case "deleteBom"://2
            this.deleteFunction(param, "MCC013");
            this.deleteFunction(param, "MCC020");
            this.deleteFunction(param, "MCC050");
            this.deleteFunction(param, "MCC021");
            this.deleteFunction(param, "MCC022");

            //외주 Bom삭제
            this.deleteFunction(param, "MWP006");

            this.updateFunction(param,"MCC015");
            break;
        case "deleteOrder"://3

            this.deleteFunction(param, "MPO009");
            this.deleteFunction(param, "MPO011");
//          this.deleteFunction(param, "MPO012"); //강동만 있음
            this.deleteFunction(param, "MPO007");
            this.deleteFunction(param, "MPO010");
            this.deleteFunction(param, "MPO008"); //동이만
            break;
        case "deleteInOut"://4
            this.deleteFunction(param, "MQC001");
            this.deleteFunction(param, "MWP012");
//          this.deleteFunction(param, "MWP013"); //강동 제품 입고 디테일
            this.deleteFunction(param, "MWP015");
            this.deleteFunction(param, "MWP016");
//          this.deleteFunction(param, "MWI001"); //강동만 있음
            break;
        case "deleteInOutNotConf"://5
            this.deleteFunction(param, "MWP012");
            this.deleteFunction(param, "MWP013");
            this.deleteFunction(param, "MWP015");
            this.deleteFunction(param, "MWP016");
//          this.deleteFunction(param, "MWI001"); //강동만 있음
            break;
        case "deleteOutsourcing"://6
//          this.deleteFunction(param, "MWP006"); //외주 Bom 제외
            this.deleteFunction(param, "MWP010");
            this.deleteFunction(param, "MWP017");
//            this.deleteFunction(param, "MWP018"); //불량 통합 외주만 있는게 아님.
            break;
        case "deleteMaterialOut"://7
//          this.deleteFunction(param, "MMA022");
            this.deleteFunction(param, "MMA024");
            this.deleteFunction(param, "MWP001");
//          this.deleteFunction(param, "MWP005");
            
            this.deleteFunction(param, "MMA025");
            this.deleteFunction(param, "MMA026");
            break;
        case "deleteOutsourcingIn"://8
            this.deleteFunction(param, "MWP010");//외주 입고 삭제
            break;
        case "deleteOutsourcingBad"://9
            this.deleteFunction(param, "MWP018");//불량 삭제
            this.deleteFunction(param, "MBM001");//불량 입고 삭제
            this.deleteFunction(param, "MBM002");//불량 출고 삭제
            break;
        case "deleteWip"://10
            this.deleteFunction(param, "MPO013");//재공품 삭제
            this.deleteFunction(param, "MPO014");//재공품 디테일 삭제
            break;
        case "deleteTest":
            //3
            this.deleteFunction(param, "MPO009");
            this.deleteFunction(param, "MPO011");
            this.deleteFunction(param, "MPO007");
            this.deleteFunction(param, "MPO010");
            
            //6
            this.deleteFunction(param, "MWP010");
            this.deleteFunction(param, "MWP017");
            this.deleteFunction(param, "MWP018");
            //7
            this.deleteFunction(param, "MMA024");
            this.deleteFunction(param, "MWP001");
            this.deleteFunction(param, "MMA025");
            this.deleteFunction(param, "MMA026");
            break;
        }

        wedEnd(request, rtn, mav);
        return mav;
    }

    public void deleteFunction(ResetVO param,String tablename) {
        tablename = tablename.toUpperCase();
        if(resetService.selectTable(tablename) > 0) resetService.deleteTable(param, "delete"+tablename);

    }

    public void updateFunction(ResetVO param,String tablename) {
        tablename = tablename.toUpperCase();
        if(resetService.selectTable(tablename) > 0) resetService.updateTable(param,"update"+tablename);
    }
}
