package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MaterialVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6058564739643230580L;
	private String factoryCd;
	private String matCd;
	private String matNm;
	private String matGrpCd;
	private String matGrpNm;
	private String matTypeCd;
	private String matTypeNm;
	private String matCustCd;
	private String matCustNm;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeDtStr;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	private String matOutUnitTypeCd;
	private Integer matWeight;
	private String matSize;
	private String matItemNm;
    private Integer bomCnt;
    private Integer matInCnt;

	private String searchMatCustNm;
	private String searchMatNm;
	private String searchMatTypeCd;
	private String searchBomMatFilter;
	private String searchItemCd;




	public Integer getBomCnt() {
		return bomCnt;
	}
	public void setBomCnt(Integer bomCnt) {
		this.bomCnt = bomCnt;
	}
	public Integer getMatInCnt() {
		return matInCnt;
	}
	public void setMatInCnt(Integer matInCnt) {
		this.matInCnt = matInCnt;
	}
	public String getMatItemNm() {
		return matItemNm;
	}
	public void setMatItemNm(String matItemNm) {
		this.matItemNm = matItemNm;
	}
	public String getMatOutUnitTypeCd() {
		return matOutUnitTypeCd;
	}
	public void setMatOutUnitTypeCd(String matOutUnitTypeCd) {
		this.matOutUnitTypeCd = matOutUnitTypeCd;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getMatCd() {
		return matCd;
	}
	public void setMatCd(String matCd) {
		this.matCd = matCd;
	}
	public String getMatNm() {
		return matNm;
	}
	public void setMatNm(String matNm) {
		this.matNm = matNm;
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
	public String getMatTypeCd() {
		return matTypeCd;
	}
	public void setMatTypeCd(String matTypeCd) {
		this.matTypeCd = matTypeCd;
	}
	public String getMatTypeNm() {
		return matTypeNm;
	}
	public void setMatTypeNm(String matTypeNm) {
		this.matTypeNm = matTypeNm;
	}


	public Integer getMatWeight() {
		return matWeight;
	}
	public void setMatWeight(Integer matWeight) {
		this.matWeight = matWeight;
	}
	public String getMatSize() {
		return matSize;
	}
	public void setMatSize(String matSize) {
		this.matSize = matSize;
	}
	public String getMatCustCd() {
		return matCustCd;
	}
	public void setMatCustCd(String matCustCd) {
		this.matCustCd = matCustCd;
	}
	public String getMatCustNm() {
		return matCustNm;
	}
	public void setMatCustNm(String matCustNm) {
		this.matCustNm = matCustNm;
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
	public String getSearchMatCustNm() {
		return searchMatCustNm;
	}
	public void setSearchMatCustNm(String searchMatCustNm) {
		this.searchMatCustNm = searchMatCustNm;
	}
	public String getSearchMatNm() {
		return searchMatNm;
	}
	public void setSearchMatNm(String searchMatNm) {
		this.searchMatNm = searchMatNm;
	}
	public String getSearchMatTypeCd() {
		return searchMatTypeCd;
	}
	public void setSearchMatTypeCd(String searchMatTypeCd) {
		this.searchMatTypeCd = searchMatTypeCd;
	}
	public String getSearchBomMatFilter() {
		return searchBomMatFilter;
	}
	public void setSearchBomMatFilter(String searchBomMatFilter) {
		this.searchBomMatFilter = searchBomMatFilter;
	}
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
}
