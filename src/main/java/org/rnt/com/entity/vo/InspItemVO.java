package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class InspItemVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 779525491186616732L;
	private String factoryCd;
	private String inspItemCd;
	private String inspItemNm;
	private String inspTypeCd;
	private String inspTypeNm;
	private String inspItemTypeCd;
	private String inspItemTypeNm;
	private Double highVal;
	private Double lowVal;
	private String inspDanwiCd;
	private String inspDanwiNm;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String searchInspTypeCd;
	private String searchInspItemNm;
	private String searchItemCd;
	private String searchOperSeq;

    public String getInspDanwiNm() {
		return inspDanwiNm;
	}
	public void setInspDanwiNm(String inspDanwiNm) {
		this.inspDanwiNm = inspDanwiNm;
	}
	public String getSearchItemCd() {
        return searchItemCd;
    }
    public void setSearchItemCd(String searchItemCd) {
        this.searchItemCd = searchItemCd;
    }
    public String getSearchOperSeq() {
        return searchOperSeq;
    }
    public void setSearchOperSeq(String searchOperSeq) {
        this.searchOperSeq = searchOperSeq;
    }
    public String getSearchInspTypeCd() {
		return searchInspTypeCd;
	}
	public void setSearchInspTypeCd(String searchInspTypeCd) {
		this.searchInspTypeCd = searchInspTypeCd;
	}
	public String getSearchInspItemNm() {
		return searchInspItemNm;
	}
	public void setSearchInspItemNm(String searchInspItemNm) {
		this.searchInspItemNm = searchInspItemNm;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getInspItemCd() {
		return inspItemCd;
	}
	public void setInspItemCd(String inspItemCd) {
		this.inspItemCd = inspItemCd;
	}
	public String getInspItemNm() {
		return inspItemNm;
	}
	public void setInspItemNm(String inspItemNm) {
		this.inspItemNm = inspItemNm;
	}
	public String getInspTypeCd() {
		return inspTypeCd;
	}
	public void setInspTypeCd(String inspTypeCd) {
		this.inspTypeCd = inspTypeCd;
	}
	public String getInspTypeNm() {
		return inspTypeNm;
	}
	public void setInspTypeNm(String inspTypeNm) {
		this.inspTypeNm = inspTypeNm;
	}
	public String getInspItemTypeCd() {
		return inspItemTypeCd;
	}
	public void setInspItemTypeCd(String inspItemTypeCd) {
		this.inspItemTypeCd = inspItemTypeCd;
	}
	public String getInspItemTypeNm() {
		return inspItemTypeNm;
	}
	public void setInspItemTypeNm(String inspItemTypeNm) {
		this.inspItemTypeNm = inspItemTypeNm;
	}
	public Double getHighVal() {
		return highVal;
	}
	public void setHighVal(Double highVal) {
		this.highVal = highVal;
	}
	public Double getLowVal() {
		return lowVal;
	}
	public void setLowVal(Double lowVal) {
		this.lowVal = lowVal;
	}
	public String getInspDanwiCd() {
		return inspDanwiCd;
	}
	public void setInspDanwiCd(String inspDanwiCd) {
		this.inspDanwiCd = inspDanwiCd;
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
