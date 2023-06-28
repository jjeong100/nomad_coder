package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class OutSocVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 7834852579112274836L;
	private String factoryCd;
	private String outSocSeq;
	private String outSocSdt;
	private String outSocEdt;
	private String outCustCd;
	private String outCustNm;
	private String outMatCd;
	private String outMatNm;
	private Integer outMatQty;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeDtStr;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	
	private String searchOutMatNm;
	private String searchOutCustNm;

	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getOutSocSeq() {
		return outSocSeq;
	}
	public void setOutSocSeq(String outSocSeq) {
		this.outSocSeq = outSocSeq;
	}
	public String getOutSocSdt() {
		return outSocSdt;
	}
	public void setOutSocSdt(String outSocSdt) {
		this.outSocSdt = outSocSdt;
	}
	public String getOutSocEdt() {
		return outSocEdt;
	}
	public void setOutSocEdt(String outSocEdt) {
		this.outSocEdt = outSocEdt;
	}
	public String getOutCustCd() {
		return outCustCd;
	}
	public void setOutCustCd(String outCustCd) {
		this.outCustCd = outCustCd;
	}
	public String getOutCustNm() {
		return outCustNm;
	}
	public void setOutCustNm(String outCustNm) {
		this.outCustNm = outCustNm;
	}
	public String getOutMatCd() {
		return outMatCd;
	}
	public void setOutMatCd(String outMatCd) {
		this.outMatCd = outMatCd;
	}
	public String getOutMatNm() {
		return outMatNm;
	}
	public void setOutMatNm(String outMatNm) {
		this.outMatNm = outMatNm;
	}
	public Integer getOutMatQty() {
		return outMatQty;
	}
	public void setOutMatQty(Integer outMatQty) {
		this.outMatQty = outMatQty;
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
	public String getWriteDtStr() {
		return writeDtStr;
	}
	public void setWriteDtStr(String writeDtStr) {
		this.writeDtStr = writeDtStr;
	}
	public String getWriteId() {
		return writeId;
	}
	public void setWriteId(String writeId) {
		this.writeId = writeId;
	}
	public String getWriteNm() {
		return writeNm;
	}
	public void setWriteNm(String writeNm) {
		this.writeNm = writeNm;
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
	public String getSearchOutMatNm() {
		return searchOutMatNm;
	}
	public void setSearchOutMatNm(String searchOutMatNm) {
		this.searchOutMatNm = searchOutMatNm;
	}
	public String getSearchOutCustNm() {
		return searchOutCustNm;
	}
	public void setSearchOutCustNm(String searchOutCustNm) {
		this.searchOutCustNm = searchOutCustNm;
	}
}
