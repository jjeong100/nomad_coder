package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class OperationVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 276195185796073507L;
    private String factoryCd;
    private String operSeq;
    private String operCd;
    private String operNm;
    private String operRnm;
    private String outcustYn;
    private String custCd;
    private String custNm;
    private String moldCd;
    private String moldSeq;
    private String equipCd;
    private String equipNm;
    private String equipSeq;
    private String operChkYn;
    private String bigo;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    // add
    private String searchOperNm;
    private String bomNotInYn;
    private String itemCd;
    private String visionYn;
    
    private String searchOperCd;

    public String getSearchOperCd() {
        return searchOperCd;
    }
    public void setSearchOperCd(String searchOperCd) {
        this.searchOperCd = searchOperCd;
    }
    public String getVisionYn() {
        return visionYn;
    }
    public void setVisionYn(String visionYn) {
        this.visionYn = visionYn;
    }
    public String getItemCd() {
        return itemCd;
    }
    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }
    public String getBomNotInYn() {
        return bomNotInYn;
    }
    public void setBomNotInYn(String bomNotInYn) {
        this.bomNotInYn = bomNotInYn;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getOperSeq() {
        return operSeq;
    }
    public void setOperSeq(String operSeq) {
        this.operSeq = operSeq;
    }
    public String getOperCd() {
        return operCd;
    }
    public void setOperCd(String operCd) {
        this.operCd = operCd;
    }
    public String getOperNm() {
        return operNm;
    }
    public void setOperNm(String operNm) {
        this.operNm = operNm;
    }
    public String getOperRnm() {
        return operRnm;
    }
    public void setOperRnm(String operRnm) {
        this.operRnm = operRnm;
    }
    public String getOutcustYn() {
        return outcustYn;
    }
    public void setOutcustYn(String outcustYn) {
        this.outcustYn = outcustYn;
    }
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
    public String getMoldCd() {
        return moldCd;
    }
    public void setMoldCd(String moldCd) {
        this.moldCd = moldCd;
    }
    public String getMoldSeq() {
        return moldSeq;
    }
    public void setMoldSeq(String moldSeq) {
        this.moldSeq = moldSeq;
    }
    public String getEquipCd() {
        return equipCd;
    }
    public void setEquipCd(String equipCd) {
        this.equipCd = equipCd;
    }
    public String getEquipNm() {
        return equipNm;
    }
    public void setEquipNm(String equipNm) {
        this.equipNm = equipNm;
    }
    public String getEquipSeq() {
        return equipSeq;
    }
    public void setEquipSeq(String equipSeq) {
        this.equipSeq = equipSeq;
    }
    public String getOperChkYn() {
        return operChkYn;
    }
    public void setOperChkYn(String operChkYn) {
        this.operChkYn = operChkYn;
    }
    public String getBigo() {
        return bigo;
    }
    public void setBigo(String bigo) {
        this.bigo = bigo;
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
    public String getSearchOperNm() {
        return searchOperNm;
    }
    public void setSearchOperNm(String searchOperNm) {
        this.searchOperNm = searchOperNm;
    }

}
