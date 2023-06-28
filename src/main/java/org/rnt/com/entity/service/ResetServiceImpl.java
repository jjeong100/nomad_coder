package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.ResetDao;
import org.rnt.com.entity.vo.ResetVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("resetService")
public class ResetServiceImpl extends BaseService implements ResetService{

    @Resource(name="resetDao")
    private ResetDao resetDao;
    
    @Override
    public RtnVO updateTable(ResetVO param,String queryId) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = resetDao.updateTable(param,queryId);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO deleteTable(ResetVO param,String queryId) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = resetDao.deleteTable(param,queryId);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectTable(ResetVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = resetDao.selectTable(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public int selectTable(String tableName) {
        ResetVO resetVO = new ResetVO();
        resetVO.setTableName(tableName);
//        System.out.println("■■■■■■■■■■ lmpl : "+selectTable(resetVO).getObj());
        return (Integer)selectTable(resetVO).getObj();
    }
    
    @Override
	public RtnVO insert(ResetVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = resetDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ResetVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = resetDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
