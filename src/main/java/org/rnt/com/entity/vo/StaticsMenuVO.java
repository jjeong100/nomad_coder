package org.rnt.com.entity.vo;
import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.rnt.com.vo.SearchDefaultVO;

public class StaticsMenuVO extends SearchDefaultVO implements Serializable {
    private static final long serialVersionUID = 5738159646762474971L;
    
    private String factoryCd;
    private String kpidtlSeq;
    private String kpiSeq;
    private int year;
    private int month;
    private String prodSeq;
    private String itemCd;
    private String poCalldt;
    private String operSeq;
    private String equipSeq;
    private int maintenanceTime;
    private int facShutdownTime;
    private int facOperationTime;
    private double facOperationRate;
    private int finishedQty;
    private int failQty;
    private int stockQty;
    private String completionDate;
    private String deliveryDate;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    
    private int preMonthStock;
    
    private String searchItemCd;
    
    
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getKpidtlSeq() {
        return kpidtlSeq;
    }
    public void setKpidtlSeq(String kpidtlSeq) {
        this.kpidtlSeq = kpidtlSeq;
    }
    public String getKpiSeq() {
        return kpiSeq;
    }
    public void setKpiSeq(String kpiSeq) {
        this.kpiSeq = kpiSeq;
    }
    
    public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getItemCd() {
        return itemCd;
    }
    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }
    public String getPoCalldt() {
        return poCalldt;
    }
    public void setPoCalldt(String poCalldt) {
        this.poCalldt = poCalldt;
    }
    
    public String getOperSeq() {
        return operSeq;
    }
    public void setOperSeq(String operSeq) {
        this.operSeq = operSeq;
    }
    public String getEquipSeq() {
        return equipSeq;
    }
    public void setEquipSeq(String equipSeq) {
        this.equipSeq = equipSeq;
    }
    public int getMaintenanceTime() {
        return maintenanceTime;
    }
    public void setMaintenanceTime(int maintenanceTime) {
        this.maintenanceTime = maintenanceTime;
    }
    
    public int getFacShutdownTime() {
        return facShutdownTime;
    }
    public void setFacShutdownTime(int facShutdownTime) {
        this.facShutdownTime = facShutdownTime;
    }
    public int getFacOperationTime() {
        return facOperationTime;
    }
    public void setFacOperationTime(int facOperationTime) {
        this.facOperationTime = facOperationTime;
    }
    public double getFacOperationRate() {
        return facOperationRate;
    }
    public void setFacOperationRate(double facOperationRate) {
        this.facOperationRate = facOperationRate;
    }
    public int getFinishedQty() {
        return finishedQty;
    }
    public void setFinishedQty(int finishedQty) {
        this.finishedQty = finishedQty;
    }
    public int getFailQty() {
        return failQty;
    }
    public void setFailQty(int failQty) {
        this.failQty = failQty;
    }
    public int getStockQty() {
        return stockQty;
    }
    public void setStockQty(int stockQty) {
        this.stockQty = stockQty;
    }
    public String getCompletionDate() {
        return completionDate;
    }
    public void setCompletionDate(String completionDate) {
        this.completionDate = completionDate;
    }
    public String getDeliveryDate() {
        return deliveryDate;
    }
    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }
    
    public int getPreMonthStock() {
        return preMonthStock;
    }
    public void setPreMonthStock(int preMonthStock) {
        this.preMonthStock = preMonthStock;
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
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
