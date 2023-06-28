package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class StockOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316275218901013782L;
	private String sbDt;        // 수불 일자
	private String workshopCd;  // 자재 창고 코드
	private String workshopNm;  // 자재 창고 명
	private String matCd;       // 자재 코드
	private String matNm;       // 자재 명
	private String baseQty;     // 기초재고
	private String inQty;       // 입고
	private String goutQty;     // 공정 출고
	private String grntQty;     // 공정 반환
	private String disuseQty;   // 폐기
	private String modifyQty;   // 재고 조정
	private String totQty;   // 최종재고
	
	private String baseUnitVal;		// 기초재고중량
	private String inUnitVal;   	// 입고중량
	private String matoutUnitVal;	// 출고중량
	private String totUnitVal;		// 최종재고중량
	private String matUnitNm;		// 중량단위
	
    public String getSbDt() {
        return sbDt;
    }
    public void setSbDt(String sbDt) {
        this.sbDt = sbDt;
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
    public String getMatCd() {
        return matCd;
    }
    public void setMatCd(String matCd) {
        this.matCd = matCd;
    }
    public String getMatNm() {
        return matNm;
    }
    public void setMatNm(String matNm) {
        this.matNm = matNm;
    }
    public String getBaseQty() {
        return baseQty;
    }
    public void setBaseQty(String baseQty) {
        this.baseQty = baseQty;
    }
    public String getInQty() {
        return inQty;
    }
    public void setInQty(String inQty) {
        this.inQty = inQty;
    }
    public String getGoutQty() {
        return goutQty;
    }
    public void setGoutQty(String goutQty) {
        this.goutQty = goutQty;
    }
    public String getGrntQty() {
        return grntQty;
    }
    public void setGrntQty(String grntQty) {
        this.grntQty = grntQty;
    }
    public String getDisuseQty() {
        return disuseQty;
    }
    public void setDisuseQty(String disuseQty) {
        this.disuseQty = disuseQty;
    }
    public String getModifyQty() {
        return modifyQty;
    }
    public void setModifyQty(String modifyQty) {
        this.modifyQty = modifyQty;
    }
	public String getTotQty() {
		return totQty;
	}
	public void setTotQty(String totQty) {
		this.totQty = totQty;
	}
	public String getInUnitVal() {
		return inUnitVal;
	}
	public void setInUnitVal(String inUnitVal) {
		this.inUnitVal = inUnitVal;
	}
	public String getMatoutUnitVal() {
		return matoutUnitVal;
	}
	public void setMatoutUnitVal(String matoutUnitVal) {
		this.matoutUnitVal = matoutUnitVal;
	}
	public String getBaseUnitVal() {
		return baseUnitVal;
	}
	public void setBaseUnitVal(String baseUnitVal) {
		this.baseUnitVal = baseUnitVal;
	}
	public String getTotUnitVal() {
		return totUnitVal;
	}
	public void setTotUnitVal(String totUnitVal) {
		this.totUnitVal = totUnitVal;
	}
	public String getMatUnitNm() {
		return matUnitNm;
	}
	public void setMatUnitNm(String matUnitNm) {
		this.matUnitNm = matUnitNm;
	}
}
