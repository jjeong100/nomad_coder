package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.InspRltDao;
import org.rnt.com.entity.vo.InspRltVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("inspRltService")
public class InspRltServiceImpl extends BaseService implements InspRltService{

    @Resource(name="inspRltDao")
    private InspRltDao inspRltDao;

    @Override
    public RtnVO insert(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO select(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.select(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO update(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO delete(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.delete(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO deleteAll(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.deleteAll(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchList(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.searchList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchListTotCnt(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.searchListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO searchInspRsltList(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.searchInspRsltList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    
    @Override
    public RtnVO getInspDaySeq(InspRltVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = inspRltDao.getInspDaySeq(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
