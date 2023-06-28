package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MaterialGrpVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6754836671292066722L;
	private String factoryCd;
	private String matGrpCd;
	private String matGrpNm;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeDtStr;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	private String beforeMatGrpCd;

	private String searchMatGrpNm;

	public String getBeforeMatGrpCd() {
		return beforeMatGrpCd;
	}
	public void setBeforeMatGrpCd(String beforeMatGrpCd) {
		this.beforeMatGrpCd = beforeMatGrpCd;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getMatGrpCd() {
		return matGrpCd;
	}
	public void setMatGrpCd(String matGrpCd) {
		this.matGrpCd = matGrpCd;
	}
	public String getMatGrpNm() {
		return matGrpNm;
	}
	public void setMatGrpNm(String matGrpNm) {
		this.matGrpNm = matGrpNm;
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
	public String getSearchMatGrpNm() {
		return searchMatGrpNm;
	}
	public void setSearchMatGrpNm(String searchMatGrpNm) {
		this.searchMatGrpNm = searchMatGrpNm;
	}

}
