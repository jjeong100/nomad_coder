package org.rnt.report.vo;

import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class ReportVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String factoryCd;
	private String rptSeq;
	private String rptDivCd;
	private String writeYmd;
	private String cont1;
	private String cont2;
	private String cont3;
	private String inspectId;
	private String inspectNm;
	private String approveId;
	private String approveNm;
	private String measureId;
	private String measureNm;
	private String confirmId;
	private String confirmNm;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	
	private List<ReportDtlVO> reportDtlList;
	
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
	public String getRptDivCd() {
		return rptDivCd;
	}
	public void setRptDivCd(String rptDivCd) {
		this.rptDivCd = rptDivCd;
	}
	public String getWriteYmd() {
		return writeYmd;
	}
	public void setWriteYmd(String writeYmd) {
		this.writeYmd = writeYmd;
	}
	public String getCont1() {
		return cont1;
	}
	public void setCont1(String cont1) {
		this.cont1 = cont1;
	}
	public String getCont2() {
		return cont2;
	}
	public void setCont2(String cont2) {
		this.cont2 = cont2;
	}
	public String getCont3() {
		return cont3;
	}
	public void setCont3(String cont3) {
		this.cont3 = cont3;
	}
	public String getInspectId() {
		return inspectId;
	}
	public void setInspectId(String inspectId) {
		this.inspectId = inspectId;
	}
	public String getInspectNm() {
		return inspectNm;
	}
	public void setInspectNm(String inspectNm) {
		this.inspectNm = inspectNm;
	}
	public String getApproveId() {
		return approveId;
	}
	public void setApproveId(String approveId) {
		this.approveId = approveId;
	}
	public String getApproveNm() {
		return approveNm;
	}
	public void setApproveNm(String approveNm) {
		this.approveNm = approveNm;
	}
	public String getMeasureId() {
		return measureId;
	}
	public void setMeasureId(String measureId) {
		this.measureId = measureId;
	}
	public String getMeasureNm() {
		return measureNm;
	}
	public void setMeasureNm(String measureNm) {
		this.measureNm = measureNm;
	}
	public String getConfirmId() {
		return confirmId;
	}
	public void setConfirmId(String confirmId) {
		this.confirmId = confirmId;
	}
	public String getConfirmNm() {
		return confirmNm;
	}
	public void setConfirmNm(String confirmNm) {
		this.confirmNm = confirmNm;
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
	public List<ReportDtlVO> getReportDtlList() {
		return reportDtlList;
	}
	public void setReportDtlList(List<ReportDtlVO> reportDtlList) {
		this.reportDtlList = reportDtlList;
	}
	
}
