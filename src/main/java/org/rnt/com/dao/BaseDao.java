package org.rnt.com.dao;

import org.rnt.com.GlvConst;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;

public class BaseDao {
    public RtnVO setRtnVO(RtnVO rtnVO, String msg, String exceptionMsg) {
        rtnVO.setRc(GlvConst.RC_ERROR);
        rtnVO.setMsg(msg);
        if (!StrUtil.isNull(exceptionMsg)) {
//        	rtnVO.setExceptionMsg(StrUtil.getLastAfterStr(exceptionMsg.replaceAll("\"", ""),"Cause") );
        	rtnVO.setExceptionMsg(exceptionMsg);
        }
        rtnVO.setExceptionClassName((new Throwable()).getStackTrace()[1].getClassName());
        rtnVO.setExceptionMethodName((new Throwable()).getStackTrace()[1].getMethodName());
        rtnVO.setExceptionLine((new Throwable()).getStackTrace()[1].getLineNumber());
        return rtnVO;
    }
}
