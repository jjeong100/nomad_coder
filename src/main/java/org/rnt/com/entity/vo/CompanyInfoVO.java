package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class CompanyInfoVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 6180705473565968134L;
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
