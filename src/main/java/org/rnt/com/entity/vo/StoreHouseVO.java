package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class StoreHouseVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 5925182842447479330L;
	private String factoryCd;
	private String workshopCd;
	private String workshopNm;
	private String areaCd;
	private String areaNm;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
    private String searchWorkshopNm;
    private String searchAreaCd;
    
    public String getSearchAreaCd() {
        return searchAreaCd;
    }
    public void setSearchAreaCd(String searchAreaCd) {
        this.searchAreaCd = searchAreaCd;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getWorkshopCd() {
        return workshopCd;
    }
    public void setWorkshopCd(String workshopCd) {
        this.workshopCd = workshopCd;
    }
    public String getWorkshopNm() {
        return workshopNm;
    }
    public void setWorkshopNm(String workshopNm) {
        this.workshopNm = workshopNm;
    }
    public String getAreaCd() {
        return areaCd;
    }
    public void setAreaCd(String areaCd) {
        this.areaCd = areaCd;
    }
    public String getAreaNm() {
        return areaNm;
    }
    public void setAreaNm(String areaNm) {
        this.areaNm = areaNm;
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
    public String getSearchWorkshopNm() {
        return searchWorkshopNm;
    }
    public void setSearchWorkshopNm(String searchWorkshopNm) {
        this.searchWorkshopNm = searchWorkshopNm;
    }
    
	
}
