package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkGroupVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 2929820424328661814L;
	private String factoryCd;
	private String workCd;
	private String workNm;
	private String startWrtm;
	private String endWrtm;
	private String foodWrtm;
	private String idleWrtm;
	private String changeWrtm;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
    // add
	private String searchWorkNm;
	
	public String getSearchWorkNm() {
        return searchWorkNm;
    }
    public void setSearchWorkNm(String searchWorkNm) {
        this.searchWorkNm = searchWorkNm;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getWorkCd() {
		return workCd;
	}
	public void setWorkCd(String workCd) {
		this.workCd = workCd;
	}
	public String getWorkNm() {
		return workNm;
	}
	public void setWorkNm(String workNm) {
		this.workNm = workNm;
	}
	public String getStartWrtm() {
		return startWrtm;
	}
	public void setStartWrtm(String startWrtm) {
		this.startWrtm = startWrtm;
	}
	public String getEndWrtm() {
		return endWrtm;
	}
	public void setEndWrtm(String endWrtm) {
		this.endWrtm = endWrtm;
	}
	public String getFoodWrtm() {
		return foodWrtm;
	}
	public void setFoodWrtm(String foodWrtm) {
		this.foodWrtm = foodWrtm;
	}
	public String getIdleWrtm() {
		return idleWrtm;
	}
	public void setIdleWrtm(String idleWrtm) {
		this.idleWrtm = idleWrtm;
	}
	public String getChangeWrtm() {
		return changeWrtm;
	}
	public void setChangeWrtm(String changeWrtm) {
		this.changeWrtm = changeWrtm;
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
