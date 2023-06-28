package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class TranSpecVO extends SearchDefaultVO implements Serializable {
    
    private static final long serialVersionUID = 8018500504230198618L;

    private String factoryCd;
    private String businNo;
    private String mutualNm;
    private String ceoNm;
    private String addr;
    private String businCond;
    private String partsCategory;
    private String telNo;       
    private String faxNo;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    
    private String custCd;
    private String custNm;
    private String custAddr;
    private String custCeoNm;
    private String custBusinNo;
    private String custBusinCond;
    private String custPartsCategory;
    
    public String getCustCd() {
        return custCd;
    }
    public void setCustCd(String custCd) {
        this.custCd = custCd;
    }
    public String getCustNm() {
        return custNm;
    }
    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }
    public String getCustAddr() {
        return custAddr;
    }
    public void setCustAddr(String custAddr) {
        this.custAddr = custAddr;
    }
    public String getCustCeoNm() {
        return custCeoNm;
    }
    public void setCustCeoNm(String custCeoNm) {
        this.custCeoNm = custCeoNm;
    }
    public String getCustBusinNo() {
        return custBusinNo;
    }
    public void setCustBusinNo(String custBusinNo) {
        this.custBusinNo = custBusinNo;
    }
    public String getCustBusinCond() {
        return custBusinCond;
    }
    public void setCustBusinCond(String custBusinCond) {
        this.custBusinCond = custBusinCond;
    }
    public String getCustPartsCategory() {
        return custPartsCategory;
    }
    public void setCustPartsCategory(String custPartsCategory) {
        this.custPartsCategory = custPartsCategory;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getBusinNo() {
        return businNo;
    }
    public void setBusinNo(String businNo) {
        this.businNo = businNo;
    }
    public String getMutualNm() {
        return mutualNm;
    }
    public void setMutualNm(String mutualNm) {
        this.mutualNm = mutualNm;
    }
    public String getCeoNm() {
        return ceoNm;
    }
    public void setCeoNm(String ceoNm) {
        this.ceoNm = ceoNm;
    }
    public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }
    public String getBusinCond() {
        return businCond;
    }
    public void setBusinCond(String businCond) {
        this.businCond = businCond;
    }
    public String getPartsCategory() {
        return partsCategory;
    }
    public void setPartsCategory(String partsCategory) {
        this.partsCategory = partsCategory;
    }
    public String getTelNo() {
        return telNo;
    }
    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }
    public String getFaxNo() {
        return faxNo;
    }
    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public java.util.Date getWriteDt() {
        return writeDt;
    }
    public void setWriteDt(java.util.Date writeDt) {
        this.writeDt = writeDt;
    }
    public String getWriteId() {
        return writeId;
    }
    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }
    public java.util.Date getUpdateDt() {
        return updateDt;
    }
    public void setUpdateDt(java.util.Date updateDt) {
        this.updateDt = updateDt;
    }
    public String getUpdateId() {
        return updateId;
    }
    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }
}
