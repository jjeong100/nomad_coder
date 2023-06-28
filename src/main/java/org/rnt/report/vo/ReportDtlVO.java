package org.rnt.report.vo;

import java.io.Serializable;

import org.rnt.com.vo.SearchDefaultVO;

public class ReportDtlVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String factoryCd;
	private String rptSeq;
	private int rptDtlSeq;
	private String col1;
	private String col2;
	private String col3;
	private String col4;
	private String col5;
	private String col6;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getRptSeq() {
		return rptSeq;
	}
	public void setRptSeq(String rptSeq) {
		this.rptSeq = rptSeq;
	}
	public int getRptDtlSeq() {
		return rptDtlSeq;
	}
	public void setRptDtlSeq(int rptDtlSeq) {
		this.rptDtlSeq = rptDtlSeq;
	}
	public String getCol1() {
		return col1;
	}
	public void setCol1(String col1) {
		this.col1 = col1;
	}
	public String getCol2() {
		return col2;
	}
	public void setCol2(String col2) {
		this.col2 = col2;
	}
	public String getCol3() {
		return col3;
	}
	public void setCol3(String col3) {
		this.col3 = col3;
	}
	public String getCol4() {
		return col4;
	}
	public void setCol4(String col4) {
		this.col4 = col4;
	}
	public String getCol5() {
		return col5;
	}
	public void setCol5(String col5) {
		this.col5 = col5;
	}
	public String getCol6() {
		return col6;
	}
	public void setCol6(String col6) {
		this.col6 = col6;
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
	
}
