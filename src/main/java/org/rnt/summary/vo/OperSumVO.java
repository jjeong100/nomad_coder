package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class OperSumVO extends SearchDefaultVO implements Serializable {
    private static final long serialVersionUID = -6460962594566394794L;
    
    private String poCalldt;
    private String itemCd;
    private String itemNm;
    private String poQty;
    private String actokQty;
    private String checkQty;
    private String inokQty;
    private String outQty;
    
    private String searchItemNm;
    private String searchItemCd;
    
    private String operCd;
    private String operNm;
    
    private String searchOperCd;
    
    public String getSearchOperCd() {
        return searchOperCd;
    }
    public void setSearchOperCd(String searchOperCd) {
        this.searchOperCd = searchOperCd;
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
    public String getPoCalldt() {
        return poCalldt;
    }
    public void setPoCalldt(String poCalldt) {
        this.poCalldt = poCalldt;
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
    public String getPoQty() {
        return poQty;
    }
    public void setPoQty(String poQty) {
        this.poQty = poQty;
    }
    public String getActokQty() {
        return actokQty;
    }
    public void setActokQty(String actokQty) {
        this.actokQty = actokQty;
    }
    public String getCheckQty() {
        return checkQty;
    }
    public void setCheckQty(String checkQty) {
        this.checkQty = checkQty;
    }
    public String getInokQty() {
        return inokQty;
    }
    public void setInokQty(String inokQty) {
        this.inokQty = inokQty;
    }
    public String getOutQty() {
        return outQty;
    }
    public void setOutQty(String outQty) {
        this.outQty = outQty;
    }
    public String getSearchItemNm() {
        return searchItemNm;
    }
    public void setSearchItemNm(String searchItemNm) {
        this.searchItemNm = searchItemNm;
    }
    public String getSearchItemCd() {
        return searchItemCd;
    }
    public void setSearchItemCd(String searchItemCd) {
        this.searchItemCd = searchItemCd;
    }
}
