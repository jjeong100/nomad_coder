package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipSumInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	private String searchEquipNm;
	public String getSearchEquipNm() {
		return searchEquipNm;
	}
	public void setSearchEquipNm(String searchEquipNm) {
		this.searchEquipNm = searchEquipNm;
	}
}
