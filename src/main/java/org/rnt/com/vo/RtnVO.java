package org.rnt.com.vo;

import java.io.Serializable;

public class RtnVO implements Serializable {
    static final long serialVersionUID = 4533001257186777699L;
    //-------------------------------------------------------------------------
    // RC : (0:정상,-1:실패), MSG : 실패시 오류 메시지, OBJ : data Object 
    //-------------------------------------------------------------------------
    private int rc=0;
    private String msg;
    private Object obj;
    private Integer totCnt=0;
    //-------------------------------------------------------------------------
    // 예외 발생 정보
    //-------------------------------------------------------------------------
    private String exceptionMsg;
    private int exceptionLine;
    private String exceptionClassName;
    private String exceptionMethodName;
    public int getRc() {
        return rc;
    }
    public void setRc(int rc) {
        this.rc = rc;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Object getObj() {
        return obj;
    }
    public void setObj(Object obj) {
        this.obj = obj;
    }
    public Integer getTotCnt() {
        return totCnt;
    }
    public void setTotCnt(Integer totCnt) {
        this.totCnt = totCnt;
    }
    public String getExceptionMsg() {
        return exceptionMsg;
    }
    public void setExceptionMsg(String exceptionMsg) {
        this.exceptionMsg = exceptionMsg;
    }
    public int getExceptionLine() {
        return exceptionLine;
    }
    public void setExceptionLine(int exceptionLine) {
        this.exceptionLine = exceptionLine;
    }
    public String getExceptionClassName() {
        return exceptionClassName;
    }
    public void setExceptionClassName(String exceptionClassName) {
        this.exceptionClassName = exceptionClassName;
    }
    public String getExceptionMethodName() {
        return exceptionMethodName;
    }
    public void setExceptionMethodName(String exceptionMethodName) {
        this.exceptionMethodName = exceptionMethodName;
    }
    
}
