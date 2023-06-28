package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BomInspVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 1992363835263897449L;
	private String factoryCd;
	private String bomInspSeq;
	private String bomSeq;
	private String inspTypeCd;
	private String inspTypeNm;
	private String inspItemCd;
	private String inspItemNm;
	private String inspDanwiCd;
	private String inspItemTypeCd;
	private String inspItemTypeNm;
	private Double lowVal;
	private Double highVal;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	// add 
	private String searchWorkactSeq;
	private String searchOperCd;
	private String searchBomSeq;
	private String searchInspTypeCd;
	private String searchItemCd;
    private String searchOperSeq;
	
    
	public String getInspDanwiCd() {
		return inspDanwiCd;
	}
	public void setInspDanwiCd(String inspDanwiCd) {
		this.inspDanwiCd = inspDanwiCd;
	}
	public String getSearchWorkactSeq() {
        return searchWorkactSeq;
    }
    public void setSearchWorkactSeq(String searchWorkactSeq) {
        this.searchWorkactSeq = searchWorkactSeq;
    }
    public String getSearchOperCd() {
        return searchOperCd;
    }
    public void setSearchOperCd(String searchOperCd) {
        this.searchOperCd = searchOperCd;
    }
    public String getInspItemNm() {
        return inspItemNm;
    }
    public void setInspItemNm(String inspItemNm) {
        this.inspItemNm = inspItemNm;
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
	public Double getLowVal() {
		return lowVal;
	}
	public void setLowVal(Double lowVal) {
		this.lowVal = lowVal;
	}
	public Double getHighVal() {
		return highVal;
	}
	public void setHighVal(Double highVal) {
		this.highVal = highVal;
	}
	public String getSearchBomSeq() {
		return searchBomSeq;
	}
	public void setSearchBomSeq(String searchBomSeq) {
		this.searchBomSeq = searchBomSeq;
	}
	public String getSearchInspTypeCd() {
		return searchInspTypeCd;
	}
	public void setSearchInspTypeCd(String searchInspTypeCd) {
		this.searchInspTypeCd = searchInspTypeCd;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getBomInspSeq() {
		return bomInspSeq;
	}
	public void setBomInspSeq(String bomInspSeq) {
		this.bomInspSeq = bomInspSeq;
	}
	public String getBomSeq() {
		return bomSeq;
	}
	public void setBomSeq(String bomSeq) {
		this.bomSeq = bomSeq;
	}
	public String getInspTypeCd() {
		return inspTypeCd;
	}
	public void setInspTypeCd(String inspTypeCd) {
		this.inspTypeCd = inspTypeCd;
	}
	public String getInspItemCd() {
		return inspItemCd;
	}
	public void setInspItemCd(String inspItemCd) {
		this.inspItemCd = inspItemCd;
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
