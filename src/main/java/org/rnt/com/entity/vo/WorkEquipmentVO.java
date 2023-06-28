package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkEquipmentVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = 1872741992471261451L;
	private String factoryCd;
	private String workSetSeq;
	private String prodSeq;
	private String equipCd;
	private Integer workQty;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	//add
	
	private String equipNm;
	
	
	public String getEquipNm() {
		return equipNm;
	}
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getWorkSetSeq() {
		return workSetSeq;
	}
	public void setWorkSetSeq(String workSetSeq) {
		this.workSetSeq = workSetSeq;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public Integer getWorkQty() {
		return workQty;
	}
	public void setWorkQty(Integer workQty) {
		this.workQty = workQty;
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
