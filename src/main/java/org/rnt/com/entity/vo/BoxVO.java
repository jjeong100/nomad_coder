package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BoxVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316475218901093782L;
	private String factoryCd;
	private String boxCd;
	private String boxNm;
	private Integer bwithNum;
	private Integer bheightNum;
	private Integer binCount;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
    // add
	private String searchBoxNm;
	
	public String getSearchBoxNm() {
        return searchBoxNm;
    }
    public void setSearchBoxNm(String searchBoxNm) {
        this.searchBoxNm = searchBoxNm;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getBoxCd() {
		return boxCd;
	}
	public void setBoxCd(String boxCd) {
		this.boxCd = boxCd;
	}
	public String getBoxNm() {
		return boxNm;
	}
	public void setBoxNm(String boxNm) {
		this.boxNm = boxNm;
	}
	public Integer getBwithNum() {
		return bwithNum;
	}
	public void setBwithNum(Integer bwithNum) {
		this.bwithNum = bwithNum;
	}
	public Integer getBheightNum() {
		return bheightNum;
	}
	public void setBheightNum(Integer bheightNum) {
		this.bheightNum = bheightNum;
	}
	public Integer getBinCount() {
		return binCount;
	}
	public void setBinCount(Integer binCount) {
		this.binCount = binCount;
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
