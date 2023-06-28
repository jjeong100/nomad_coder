package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BomHistoryVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 2939793863802637561L;
	private String factoryCd;
	private String itemCd;
	private String bomHisSeq;
	private String bomVer;
	private String bomStdt;
	private String operSeq;
	private String operCd;
	private String operNm;
	private String bomBigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String searchItemCd;

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
	public String getOperSeq() {
		return operSeq;
	}
	public void setOperSeq(String operSeq) {
		this.operSeq = operSeq;
	}
	public String getSearchItemCd() {
        return searchItemCd;
    }
    public void setSearchItemCd(String searchItemCd) {
        this.searchItemCd = searchItemCd;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public String getBomHisSeq() {
		return bomHisSeq;
	}
	public void setBomHisSeq(String bomHisSeq) {
		this.bomHisSeq = bomHisSeq;
	}
	public String getBomVer() {
		return bomVer;
	}
	public void setBomVer(String bomVer) {
		this.bomVer = bomVer;
	}
	public String getBomStdt() {
		return bomStdt;
	}
	public void setBomStdt(String bomStdt) {
		this.bomStdt = bomStdt;
	}
	public String getBomBigo() {
		return bomBigo;
	}
	public void setBomBigo(String bomBigo) {
		this.bomBigo = bomBigo;
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
