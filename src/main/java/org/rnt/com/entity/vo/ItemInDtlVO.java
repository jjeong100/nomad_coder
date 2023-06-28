package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemInDtlVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 6363178306468924035L;
    private String factoryCd;
    private String iteminSeq;
    private String itemindSeq;
    private String prodSeq;
    private String prodPoNo;
    private String itemCd;
    private String itemNm;
    private Double inokQty;
    private String lotid;
    private String lotIdtlId;
    private String lotIdtlWrdt;
    private String lotIdtlSabun;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    private String custNm;
    private String prodDt;
    private String limitDt;
    private String iteminDt;
    private String itemNo;
    private String matCustLotid;
    
    private Double lenVal;
	private String lenCd;
	private String lenNm;
	private String workshopCd;
	private String matLotid;
	private String searchItemNm;
	private String searchFromIteminDt;
	private String searchToIteminDt;
	private String searchLotIdtlId;
	private String iteminOutDt;
	private Double storkQty;
	private Double outQty;
	
	
    public Double getOutQty() {
		return outQty;
	}
	public void setOutQty(Double outQty) {
		this.outQty = outQty;
	}
	public Double getStorkQty() {
		return storkQty;
	}
	public void setStorkQty(Double storkQty) {
		this.storkQty = storkQty;
	}
	public String getSearchLotIdtlId() {
		return searchLotIdtlId;
	}
	public void setSearchLotIdtlId(String searchLotIdtlId) {
		this.searchLotIdtlId = searchLotIdtlId;
	}
	public String getIteminOutDt() {
		return iteminOutDt;
	}
	public void setIteminOutDt(String iteminOutDt) {
		this.iteminOutDt = iteminOutDt;
	}
	public String getSearchFromIteminDt() {
		return searchFromIteminDt;
	}
	public void setSearchFromIteminDt(String searchFromIteminDt) {
		this.searchFromIteminDt = searchFromIteminDt;
	}
	public String getSearchToIteminDt() {
		return searchToIteminDt;
	}
	public void setSearchToIteminDt(String searchToIteminDt) {
		this.searchToIteminDt = searchToIteminDt;
	}
	public String getSearchItemNm() {
		return searchItemNm;
	}
	public void setSearchItemNm(String searchItemNm) {
		this.searchItemNm = searchItemNm;
	}
	public String getMatCustLotid() {
        return matCustLotid;
    }
    public void setMatCustLotid(String matCustLotid) {
        this.matCustLotid = matCustLotid;
    }
    private String searchIteminSeq;
    
    public String getSearchIteminSeq() {
        return searchIteminSeq;
    }
    public void setSearchIteminSeq(String searchIteminSeq) {
        this.searchIteminSeq = searchIteminSeq;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getIteminSeq() {
        return iteminSeq;
    }
    public void setIteminSeq(String iteminSeq) {
        this.iteminSeq = iteminSeq;
    }
    public String getItemindSeq() {
        return itemindSeq;
    }
    public void setItemindSeq(String itemindSeq) {
        this.itemindSeq = itemindSeq;
    }
    public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getProdPoNo() {
        return prodPoNo;
    }
    public void setProdPoNo(String prodPoNo) {
        this.prodPoNo = prodPoNo;
    }
    public String getItemCd() {
        return itemCd;
    }
    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }
    public String getItemNm() {
        return itemNm;
    }
    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }
    public Double getInokQty() {
        return inokQty;
    }
    public void setInokQty(Double inokQty) {
        this.inokQty = inokQty;
    }
    public String getLotid() {
        return lotid;
    }
    public void setLotid(String lotid) {
        this.lotid = lotid;
    }
    public String getLotIdtlId() {
        return lotIdtlId;
    }
    public void setLotIdtlId(String lotIdtlId) {
        this.lotIdtlId = lotIdtlId;
    }
    public String getLotIdtlWrdt() {
        return lotIdtlWrdt;
    }
    public void setLotIdtlWrdt(String lotIdtlWrdt) {
        this.lotIdtlWrdt = lotIdtlWrdt;
    }
    public String getLotIdtlSabun() {
        return lotIdtlSabun;
    }
    public void setLotIdtlSabun(String lotIdtlSabun) {
        this.lotIdtlSabun = lotIdtlSabun;
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
    public String getCustNm() {
        return custNm;
    }
    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }
    public String getProdDt() {
        return prodDt;
    }
    public void setProdDt(String prodDt) {
        this.prodDt = prodDt;
    }
    public String getLimitDt() {
        return limitDt;
    }
    public void setLimitDt(String limitDt) {
        this.limitDt = limitDt;
    }
    public String getIteminDt() {
        return iteminDt;
    }
    public void setIteminDt(String iteminDt) {
        this.iteminDt = iteminDt;
    }
    public String getItemNo() {
        return itemNo;
    }
    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }
	public Double getLenVal() {
		return lenVal;
	}
	public void setLenVal(Double lenVal) {
		this.lenVal = lenVal;
	}
	public String getLenCd() {
		return lenCd;
	}
	public void setLenCd(String lenCd) {
		this.lenCd = lenCd;
	}
	public String getLenNm() {
		return lenNm;
	}
	public void setLenNm(String lenNm) {
		this.lenNm = lenNm;
	}
	public String getMatLotid() {
		return matLotid;
	}
	public void setMatLotid(String matLotid) {
		this.matLotid = matLotid;
	}
	public String getWorkshopCd() {
		return workshopCd;
	}
	public void setWorkshopCd(String workshopCd) {
		this.workshopCd = workshopCd;
	}
	
}
