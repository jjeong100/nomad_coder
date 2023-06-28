package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 1883570850311131077L;
	private String factoryCd;
	private String itemCd;
	private String itemNm;
	private String custCd;
	private String custNm;
	private String bomVer;
	private Integer itemWeight;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String bigo;
	private String itemSize;
	private String itemColor;

	private String itemImage;
	private String itemImagePath;
	private String itemImageData;
	// add
	private String searchItemCd;
	private String searchItemNm;
	private String searchItemTypeCd;

	private String itemTypeCd;
	private String itemTypeNm;
	private String searchCustNm;
	private String bomStdt;
	private String operCd;
	private String operNm;
	private String operSeq;
	private String writeNm;
	private String writeDtStr;
    private Integer bomCnt;
    private Integer prodOrdCnt;


 	public Integer getBomCnt() {
		return bomCnt;
	}
	public void setBomCnt(Integer bomCnt) {
		this.bomCnt = bomCnt;
	}
	public Integer getProdOrdCnt() {
		return prodOrdCnt;
	}
	public void setProdOrdCnt(Integer prodOrdCnt) {
		this.prodOrdCnt = prodOrdCnt;
	}
	public String getItemSize() {
		return itemSize;
	}
	public void setItemSize(String itemSize) {
		this.itemSize = itemSize;
	}
	public String getItemColor() {
		return itemColor;
	}
	public void setItemColor(String itemColor) {
		this.itemColor = itemColor;
	}
	public String getSearchItemTypeCd() {
		return searchItemTypeCd;
	}
	public void setSearchItemTypeCd(String searchItemTypeCd) {
		this.searchItemTypeCd = searchItemTypeCd;
	}
	public String getWriteDtStr() {
		return writeDtStr;
	}
	public void setWriteDtStr(String writeDtStr) {
		this.writeDtStr = writeDtStr;
	}
	public String getWriteNm() {
		return writeNm;
	}
	public void setWriteNm(String writeNm) {
		this.writeNm = writeNm;
	}
	public String getItemTypeNm() {
		return itemTypeNm;
	}
	public void setItemTypeNm(String itemTypeNm) {
		this.itemTypeNm = itemTypeNm;
	}
	public String getItemImagePath() {
		return itemImagePath;
	}
	public void setItemImagePath(String itemImagePath) {
		this.itemImagePath = itemImagePath;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public String getItemTypeCd() {
		return itemTypeCd;
	}
	public void setItemTypeCd(String itemTypeCd) {
		this.itemTypeCd = itemTypeCd;
	}
	public String getSearchItemNm() {
		return searchItemNm;
	}
	public void setSearchItemNm(String searchItemNm) {
		this.searchItemNm = searchItemNm;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
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
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getBomVer() {
		return bomVer;
	}
	public void setBomVer(String bomVer) {
		this.bomVer = bomVer;
	}

	public Integer getItemWeight() {
		return itemWeight;
	}
	public void setItemWeight(Integer itemWeight) {
		this.itemWeight = itemWeight;
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
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	public String getSearchCustNm() {
		return searchCustNm;
	}
	public void setSearchCustNm(String searchCustNm) {
		this.searchCustNm = searchCustNm;
	}
	public String getBomStdt() {
		return bomStdt;
	}
	public void setBomStdt(String bomStdt) {
		this.bomStdt = bomStdt;
	}
	public String getOperCd() {
		return operCd;
	}
	public void setOperCd(String operCd) {
		this.operCd = operCd;
	}
	public String getOperNm() {
		return operNm;
	}
	public void setOperNm(String operNm) {
		this.operNm = operNm;
	}
	public String getOperSeq() {
		return operSeq;
	}
	public void setOperSeq(String operSeq) {
		this.operSeq = operSeq;
	}
	public String getItemImage() {
		return itemImage;
	}
	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}
	public String getItemImageData() {
		return itemImageData;
	}
	public void setItemImageData(String itemImageData) {
		this.itemImageData = itemImageData;
	}
}
