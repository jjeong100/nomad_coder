package org.rnt.com;

public class GlvConst {
    public static final Integer RC_SUCC  = 0;
    public static final Integer RC_ERROR = -1;
    public static final String RC_SUCC_MSG = "정상 처리";
    
    
    public static final String STR_SPACE = " ";
    public static final String RC_DB_SEL_ERR_MSG = "테이블 조회 오류";
    public static final String RC_DB_CRE_ERR_MSG = "테이블 생성 오류";
    public static final String RC_DB_UPD_ERR_MSG = "테이블 변경 오류";
    public static final String RC_DB_DEL_ERR_MSG = "테이블 삭제 오류";
    
    
    public static Integer getRcSucc() {
        return RC_SUCC;
    }
    public static String getRcSuccMsg() {
        return RC_SUCC_MSG;
    }
    
    
}
