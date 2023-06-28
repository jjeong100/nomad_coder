package org.rnt.operation.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class BomTreeOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216275318901013782L;
	private String itemCd;
    private String operSeq;
    private String operUpcdSeq;
    private String operCd;  
    private String operNm;
    private Integer bomLevel;
    
    public String getItemCd() {
        return itemCd;
    }
    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }
    public String getOperSeq() {
        return operSeq;
    }
    public void setOperSeq(String operSeq) {
        this.operSeq = operSeq;
    }
    public String getOperUpcdSeq() {
        return operUpcdSeq;
    }
    public void setOperUpcdSeq(String operUpcdSeq) {
        this.operUpcdSeq = operUpcdSeq;
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
    public Integer getBomLevel() {
        return bomLevel;
    }
    public void setBomLevel(Integer bomLevel) {
        this.bomLevel = bomLevel;
    }
    
}
