package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class WorkactRsltVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = 6004033251464818224L;
	private String factoryCd;
	private String prodSeq;
	private String operCd;
	private String workactMstSeq;
	private String workactSeq;
	private String measureSeq;
	private String mjLengthCd;
	private String mjWeightCd;
	private String horizontalVal;
	private String verticalVal;
	private String heightVal;
	private String weightVal;
	private String sinteringVal;
	private String bigo;
	private String dmsLotid;
	private Integer dmsLotidSeq;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String WorkedDt;
	
	private List<WorkactRsltVO> workactRsltList;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getOperCd() {
		return operCd;
	}
	public void setOperCd(String operCd) {
		this.operCd = operCd;
	}
	public String getWorkactMstSeq() {
		return workactMstSeq;
	}
	public void setWorkactMstSeq(String workactMstSeq) {
		this.workactMstSeq = workactMstSeq;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getMeasureSeq() {
		return measureSeq;
	}
	public void setMeasureSeq(String measureSeq) {
		this.measureSeq = measureSeq;
	}
	public String getMjLengthCd() {
		return mjLengthCd;
	}
	public void setMjLengthCd(String mjLengthCd) {
		this.mjLengthCd = mjLengthCd;
	}
	public String getMjWeightCd() {
		return mjWeightCd;
	}
	public void setMjWeightCd(String mjWeightCd) {
		this.mjWeightCd = mjWeightCd;
	}
	public String getHorizontalVal() {
		return horizontalVal;
	}
	public void setHorizontalVal(String horizontalVal) {
		this.horizontalVal = horizontalVal;
	}
	public String getVerticalVal() {
		return verticalVal;
	}
	public void setVerticalVal(String verticalVal) {
		this.verticalVal = verticalVal;
	}
	public String getHeightVal() {
		return heightVal;
	}
	public void setHeightVal(String heightVal) {
		this.heightVal = heightVal;
	}
	public String getWeightVal() {
		return weightVal;
	}
	public void setWeightVal(String weightVal) {
		this.weightVal = weightVal;
	}
	public String getSinteringVal() {
		return sinteringVal;
	}
	public void setSinteringVal(String sinteringVal) {
		this.sinteringVal = sinteringVal;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public String getDmsLotid() {
		return dmsLotid;
	}
	public void setDmsLotid(String dmsLotid) {
		this.dmsLotid = dmsLotid;
	}
	public Integer getDmsLotidSeq() {
		return dmsLotidSeq;
	}
	public void setDmsLotidSeq(Integer dmsLotidSeq) {
		this.dmsLotidSeq = dmsLotidSeq;
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
	public List<WorkactRsltVO> getWorkactRsltList() {
		return workactRsltList;
	}
	public void setWorkactRsltList(List<WorkactRsltVO> workactRsltList) {
		this.workactRsltList = workactRsltList;
	}
	public String getWorkedDt() {
		return WorkedDt;
	}
	public void setWorkedDt(String workedDt) {
		WorkedDt = workedDt;
	}
	
}
