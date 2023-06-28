package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.ItemInDao;
import org.rnt.com.entity.dao.ItemInDtlDao;
import org.rnt.com.entity.vo.ItemInDtlVO;
import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemInService")
public class ItemInServiceImpl extends BaseService implements ItemInService{

    @Resource(name="itemInDao")
    private ItemInDao itemInDao;
    
    @Resource(name="itemInDtlDao")
    private ItemInDtlDao itemInDtlDao;

    @Override
    public RtnVO insert(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	
            rtn = itemInDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO select(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.select(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectProdOrderInfo(ItemInVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		rtn = itemInDao.selectProdOrderInfo(param);
    	} catch (Exception e) {
    		setRtnVO(rtn, null, e.getMessage());
    	}
    	return rtn;
    }
    
    @Override
    public RtnVO selectByLotId(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.selectByLotId(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO update(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO delete(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.delete(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchList(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.searchList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchListTotCnt(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.searchListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO selectPopItemInList(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemInDao.selectPopItemInList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
