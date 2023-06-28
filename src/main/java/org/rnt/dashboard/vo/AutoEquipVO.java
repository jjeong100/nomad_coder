package org.rnt.dashboard.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class AutoEquipVO extends SearchDefaultVO implements Serializable {
    private static final long serialVersionUID = -6017584504509060113L;
    
    private String nowDay;
    private String nowTime;
    private String totPoQty;  
    private String totActokQty;  
    private String totActbadQty;  
    private String actokRate;  
    private String actbadRate;
    
    private String searchIdx;
    private String searchProdPoNo;
    
    private String prodSeq;
    private String prodPoNo;
    private String workDt;
    private String prodTypeCd;
    private String prodTypeNm;
    
    private String itemImage;
	private String itemImagePath;
	private String itemImageData;
	
	private String equipCd;        
	private String equipNm;  
	private Integer actokQty;
	private Integer actbadQty;
	
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public String getEquipNm() {
		return equipNm;
	}
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	public Integer getActokQty() {
		return actokQty;
	}
	public void setActokQty(Integer actokQty) {
		this.actokQty = actokQty;
	}
	public Integer getActbadQty() {
		return actbadQty;
	}
	public void setActbadQty(Integer actbadQty) {
		this.actbadQty = actbadQty;
	}
	public String getItemImage() {
		return itemImage;
	}
	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}
	public String getItemImagePath() {
		return itemImagePath;
	}
	public void setItemImagePath(String itemImagePath) {
		this.itemImagePath = itemImagePath;
	}
	public String getItemImageData() {
		return itemImageData;
	}
	public void setItemImageData(String itemImageData) {
		this.itemImageData = itemImageData;
	}
	public String getProdPoNo() {
        return prodPoNo;
    }
    public void setProdPoNo(String prodPoNo) {
        this.prodPoNo = prodPoNo;
    }
    public String getWorkDt() {
        return workDt;
    }
    public void setWorkDt(String workDt) {
        this.workDt = workDt;
    }
    public String getProdTypeCd() {
        return prodTypeCd;
    }
    public void setProdTypeCd(String prodTypeCd) {
        this.prodTypeCd = prodTypeCd;
    }
    public String getProdTypeNm() {
        return prodTypeNm;
    }
    public void setProdTypeNm(String prodTypeNm) {
        this.prodTypeNm = prodTypeNm;
    }
    public String getSearchProdPoNo() {
        return searchProdPoNo;
    }
    public void setSearchProdPoNo(String searchProdPoNo) {
        this.searchProdPoNo = searchProdPoNo;
    }
    public String getSearchIdx() {
        return searchIdx;
    }
    public void setSearchIdx(String searchIdx) {
        this.searchIdx = searchIdx;
    }
    public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getNowDay() {
        return nowDay;
    }
    public void setNowDay(String nowDay) {
        this.nowDay = nowDay;
    }
    public String getNowTime() {
        return nowTime;
    }
    public void setNowTime(String nowTime) {
        this.nowTime = nowTime;
    }
    public String getTotPoQty() {
        return totPoQty;
    }
    public void setTotPoQty(String totPoQty) {
        this.totPoQty = totPoQty;
    }
    public String getTotActokQty() {
        return totActokQty;
    }
    public void setTotActokQty(String totActokQty) {
        this.totActokQty = totActokQty;
    }
    public String getTotActbadQty() {
        return totActbadQty;
    }
    public void setTotActbadQty(String totActbadQty) {
        this.totActbadQty = totActbadQty;
    }
    public String getActokRate() {
        return actokRate;
    }
    public void setActokRate(String actokRate) {
        this.actokRate = actokRate;
    }
    public String getActbadRate() {
        return actbadRate;
    }
    public void setActbadRate(String actbadRate) {
        this.actbadRate = actbadRate;
    }  
}

