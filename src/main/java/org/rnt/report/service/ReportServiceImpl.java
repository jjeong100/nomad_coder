package org.rnt.report.service;

import javax.annotation.Resource;

import org.rnt.com.entity.vo.PlcVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.report.dao.ReportDao;
import org.rnt.report.vo.ReportDtlVO;
import org.rnt.report.vo.ReportEduVO;
import org.rnt.report.vo.ReportVO;
import org.springframework.stereotype.Service;

@Service("reportService")
public class ReportServiceImpl extends BaseService implements ReportService {

	@Resource(name="reportDao")
	private ReportDao reportDao;

	@Override
	public RtnVO select(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectDtlList(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.selectDtlList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO insert(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO update(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO insertDtl(ReportDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.insertDtl(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO updateDtl(ReportDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.updateDtl(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO deleteDtl(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.deleteDtl(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.selectEdu(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO insertEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.insertEdu(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO updateEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.updateEdu(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO deleteEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.deleteEdu(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public PlcVO selectPlc(String plcCd) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = reportDao.selectPlc(plcCd);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return (PlcVO) rtn.getObj();
	}
}
