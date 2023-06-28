package org.rnt.summary.vo;
import java.io.Serializable;

public class LotTrackingMatVO extends LotTrackingVO implements Serializable {
    static final long serialVersionUID = 6216375338911013782L;
    
    private String gubun;
    private String dt;
    private String qty;
    private String lotid;
    private String prodPoNo;
    private String matCustNm;
    private String matCd;
    private String matNm;
    private String matStyle;
    private String matCustLotid;
    

    public String getMatCustLotid() {
        return matCustLotid;
    }
    public void setMatCustLotid(String matCustLotid) {
        this.matCustLotid = matCustLotid;
    }
    public String getGubun() {
        return gubun;
    }
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }
    public String getDt() {
        return dt;
    }
    public void setDt(String dt) {
        this.dt = dt;
    }
    public String getQty() {
        return qty;
    }
    public void setQty(String qty) {
        this.qty = qty;
    }
    public String getLotid() {
        return lotid;
    }
    public void setLotid(String lotid) {
        this.lotid = lotid;
    }
    public String getProdPoNo() {
        return prodPoNo;
    }
    public void setProdPoNo(String prodPoNo) {
        this.prodPoNo = prodPoNo;
    }
    public String getMatCustNm() {
        return matCustNm;
    }
    public void setMatCustNm(String matCustNm) {
        this.matCustNm = matCustNm;
    }
    public String getMatCd() {
        return matCd;
    }
    public void setMatCd(String matCd) {
        this.matCd = matCd;
    }
    public String getMatNm() {
        return matNm;
    }
    public void setMatNm(String matNm) {
        this.matNm = matNm;
    }
    public String getMatStyle() {
        return matStyle;
    }
    public void setMatStyle(String matStyle) {
        this.matStyle = matStyle;
    }
}
