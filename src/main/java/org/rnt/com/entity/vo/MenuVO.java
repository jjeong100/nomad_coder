package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MenuVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 8998692459673833292L;
	private String menuId;
	private String menuNm;
	private String menuTopNm;
	private String pageUrl;
	private Integer menuLvl;
	private Integer sortOrd;
	private String upMenuId;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	// add
	private String levelCd;
	
	public String getMenuTopNm() {
        return menuTopNm;
    }
    public void setMenuTopNm(String menuTopNm) {
        this.menuTopNm = menuTopNm;
    }
    public String getLevelCd() {
        return levelCd;
    }
    public void setLevelCd(String levelCd) {
        this.levelCd = levelCd;
    }
    public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public Integer getMenuLvl() {
		return menuLvl;
	}
	public void setMenuLvl(Integer menuLvl) {
		this.menuLvl = menuLvl;
	}
	public Integer getSortOrd() {
		return sortOrd;
	}
	public void setSortOrd(Integer sortOrd) {
		this.sortOrd = sortOrd;
	}
	public String getUpMenuId() {
		return upMenuId;
	}
	public void setUpMenuId(String upMenuId) {
		this.upMenuId = upMenuId;
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
