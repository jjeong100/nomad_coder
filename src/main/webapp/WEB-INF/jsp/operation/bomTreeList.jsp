<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<style>
.tb_wrap {
    position: relative;
    width: 100%;
    padding-top: 43px;
}

.tb_box {
    max-height: 400px;
    overflow-y: scroll;
    border-bottom: 1px solid #dedede;
}

.tb {
    border-collapse: collapse;
    border-spacing: 0;
    width: 100%;
}

.fixed_top {
    display: inline-table;
    position: absolute;
    top: 0;
    width: calc(100% - 17px);
    background: #eef7ff;
}

.fixed_top th {
    border-top: 1px solid #dedede;
    border-bottom: 1px solid #dedede;
}

.tb tr.end {
    color: #999;
}
</style>
<title>BOM</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
    //=====================================================================
    // jquery logic
    //=====================================================================
    (function($) {
        $(function() {
            //-------------------------------------------------------------
            // declare gloval
            //-------------------------------------------------------------
            $('input[type="text"]').keypress(function() {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    if ($(event.target).attr("id") == "searchMatNm") {
                        $('#btnMatSearch').click();
                    }
                }
            });

            //-------------------------------------------------------------
            // 컬럼 소트 이벤트
            //-------------------------------------------------------------
            $('#popItemTable').find('th').not('.no-sort').click(function() {
                var frm = document.itemSearchForm;
                var sortCol = $(this).attr("id");
                frm.sortCol.value = sortCol;
                var sortColType = $(this).attr('class');
                if (sortColType == 'sorting_asc') {
                    frm.sortType.value = 'desc'
                } else {
                    frm.sortType.value = 'asc'
                }

                getItemData();
            });

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------
            // 검색 이벤트
            //-------------------------------------------------------------
            $('#btnSearch').click(function() {
                getBomTreeData(true);
            });

            $("#viewItemNm").keyup(function() {
                getBomTreeData(true);
            });

            $('#btnItemSearch').click(function() {
                getItemData();
            });

            $('#btnMatSearch').click(function() {
                getMatData();
            });
            $('#btnInspItemSearch').click(function() {
                getInspItemData(document.inspItemForm.searchInspTypeCd.value);
            });

            //-------------------------------------------------------------
            // BOM TREE 선택
            //-------------------------------------------------------------
            var GLV_OPER_SEQ;
            $('#jstree').on("changed.jstree", function(e, data) {
                if (data.selected != '' && data.selected != 0) {
                    var selected = data.node.id;
                    var selecteds = selected.split('|');
                    if (selecteds.length == 2) {
                        document.searchForm.searchItemCd.value = selecteds[0];
                        GLV_OPER_SEQ = selecteds[1];
                        drawBomOperList(GLV_OPER_SEQ);
                        drawBomMatList(GLV_OPER_SEQ);
                        drawjjInspItemList(GLV_OPER_SEQ);
                        drawptInspItemList(GLV_OPER_SEQ);
                        drawBomHistoryList();
                    } else if (selecteds.length == 1) {
                        document.searchForm.searchItemCd.value = selecteds[0];
                        drawBomOperList('9999999');
                        drawBomMatList('9999999');
                        drawjjInspItemList('9999999');
                        drawptInspItemList('9999999');
                        drawBomHistoryList();
                    }
                }
            });

            drawBomOperList = function(operSeq) {
                document.searchBomForm.searchItemCd.value = document.searchForm.searchItemCd.value;
                document.searchBomForm.searchOperSeq.value = operSeq;
                document.searchBomForm.searchBomTypeCd.value = 'OP';
                $.ajax({
                    url : "<c:url value='/bomListData.do'/>",
                    type : 'POST',
                    data : $('#searchBomForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#bomOperationListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\">" + val.rnum + "</td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.operCd + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.operNm + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.bomVer + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.bomStdt + "</span></td>";
                            html += "</tr>";
                            $("#bomOperationListBody").append(html);
                        });
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            drawBomMatList = function(operSeq) {
                document.searchBomForm.searchItemCd.value = document.searchForm.searchItemCd.value;
                document.searchBomForm.searchOperSeq.value = operSeq;
                document.searchBomForm.searchBomTypeCd.value = 'MT';
                $.ajax({
                    url : "<c:url value='/bomListData.do'/>",
                    type : 'POST',
                    data : $('#searchBomForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#bomMatListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\">";
                            html += "<input type=\"radio\" name=\"bomMatRadioBox\" value=\""+val.bomSeq+"\"/>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.matNm + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(val.demandQty) + "</span></td>";
                            html += "</tr>";
                            $("#bomMatListBody").append(html);
                        });
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            drawBomHistoryList = function() {
                document.searchBomHistoryForm.searchItemCd.value = document.searchForm.searchItemCd.value;
                $.ajax({
                    url : "<c:url value='/bomHistoryListData.do'/>",
                    type : 'POST',
                    data : $('#searchBomHistoryForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#bomHistoryListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\"><span>" + val.rnum + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.bomVer + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.bomStdt + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.bomBigo + "</span></td>";
                            html += "</tr>";
                            $("#bomHistoryListBody").append(html);
                        });
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };
            drawjjInspItemList = function(operSeq) {
                document.searchBomInspForm.searchItemCd.value = document.searchForm.searchItemCd.value;
                document.searchBomInspForm.searchOperSeq.value = operSeq;
                document.searchBomInspForm.searchInspTypeCd.value = 'JJ';

                $.ajax({
                    url : "<c:url value='/bomInspItemListData.do'/>",
                    type: 'POST',
                    data: $('#searchBomInspForm').serialize(),
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    context:this,
                    dataType:'json',
                    beforeSend:function(){
                        $("#jjInspListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success: function(data) {
                        if(!cfCheckRtnObj(data.rtn)) return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val){
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\">";
                            html += "<input type=\"checkbox\" name=\"bomInspItemRadioBox\" value=\""+val.bomInspSeq+"\"/>";
                            html += "<input type=\"hidden\" id=\"bomSeq_"+val.bomInspSeq+"\"     name=\"bomSeq\"     value=\""+val.bomSeq+"\"/>";
                            html += "<input type=\"hidden\" id=\"inspItemCd_"+val.bomInspSeq+"\" name=\"inspItemCd\" value=\""+val.inspItemCd+"\"/>";
                            html += "<input type=\"hidden\" id=\"inspTypeCd_"+val.bomInspSeq+"\" name=\"inspTypeCd\" value=\""+val.inspTypeCd+"\"/>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemCd+"</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemNm+"</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemTypeNm+"</td>";
                            if(val.inspItemTypeCd != 'YN') {
                                html += "<td class=\"text-ellipsis\"><input type=\"text\" class=\"form-control input-lg radius\" style=\"padding:0px 0px 0px 0px;\" placeholder=\"하한값\" id=\"lowVal_"+val.bomInspSeq+"\" name=\"lowVal\" value=\""+cfIsNullString(val.lowVal)+"\" onKeyUp=\"javascript:onKeyUpEvent(this);\" /></td>";
                                html += "<td class=\"text-ellipsis\"><input type=\"text\" class=\"form-control input-lg radius\" style=\"padding:0px 0px 0px 0px;\" placeholder=\"상한값\" id=\"highVal_"+val.bomInspSeq+"\" name=\"highVal\" value=\""+cfIsNullString(val.highVal)+"\" onKeyUp=\"javascript:onKeyUpEvent(this);\" /></td>";
                            }else{
                                html += "<td class=\"text-ellipsis\"></td>";
                                html += "<td class=\"text-ellipsis\"></td>";
                            }
                            html += "</tr>";
                            $("#jjInspListBody").append(html);
                        });
                    },
                    error: function(request, status, error){
                        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete:function(){
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };
            //-------------------------------------------------------------
            // 패트롤 검사 항목 목록 그리기
            //-------------------------------------------------------------
            drawptInspItemList = function(operSeq) {
                document.searchBomInspForm.searchItemCd.value = document.searchForm.searchItemCd.value;
                document.searchBomInspForm.searchOperSeq.value = operSeq;
                document.searchBomInspForm.searchInspTypeCd.value = 'PT';
                $.ajax({
                    url : "<c:url value='/bomInspItemListData.do'/>",
                    type: 'POST',
                    data: $('#searchBomInspForm').serialize(),
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    context:this,
                    dataType:'json',
                    beforeSend:function(){
                        $("#ptInspListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success: function(data) {
                        if(!cfCheckRtnObj(data.rtn)) return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val){
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\">";
                            html += "<input type=\"checkbox\" name=\"bomInspPtItemRadioBox\" value=\""+val.bomInspSeq+"\"/>";
                            html += "<input type=\"hidden\" id=\"bomSeq_"+val.bomInspSeq+"\"     name=\"bomSeq\"     value=\""+val.bomSeq+"\"/>";
                            html += "<input type=\"hidden\" id=\"inspItemCd_"+val.bomInspSeq+"\" name=\"inspItemCd\" value=\""+val.inspItemCd+"\"/>";
                            html += "<input type=\"hidden\" id=\"inspTypeCd_"+val.bomInspSeq+"\" name=\"inspTypeCd\" value=\""+val.inspTypeCd+"\"/>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemCd+"</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemNm+"</td>";
                            html += "<td class=\"text-ellipsis\">"+val.inspItemTypeNm+"</td>";
                            if(val.inspItemTypeCd != 'YN') {
                                 html += "<td class=\"text-ellipsis\"><input type=\"text\" class=\"form-control input-lg radius\" style=\"padding:0px 0px 0px 0px;\" placeholder=\"하한값\" id=\"lowVal_"+val.bomInspSeq+"\" name=\"lowVal\" value=\""+cfIsNullString(val.lowVal)+"\" onKeyUp=\"javascript:onKeyUpEvent(this);\" /></td>";
                                 html += "<td class=\"text-ellipsis\"><input type=\"text\" class=\"form-control input-lg radius\" style=\"padding:0px 0px 0px 0px;\" placeholder=\"상한값\" id=\"highVal_"+val.bomInspSeq+"\" name=\"highVal\" value=\""+cfIsNullString(val.highVal)+"\" onKeyUp=\"javascript:onKeyUpEvent(this);\" /></td>";
                            }else{
                                html += "<td class=\"text-ellipsis\"></td>";
                                html += "<td class=\"text-ellipsis\"></td>";
                            }

                            html += "</tr>";
                            $("#ptInspListBody").append(html);
                        });
                    },
                    error: function(request, status, error){
                        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete:function(){
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };


            //-------------------------------------------------------------
            // BOM 생성
            //-------------------------------------------------------------
            $('#btnBomCreate').click(function() {
                if ($("#searchItemCd").val().trim() == '') {
                    alert("제품을 선택해 주세요");
                    $("#searchItemCd").focus();
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                if (tmpParent == '') {
                    alert("추가 대상 상위 BOM을 선택해 주세요");
                    return false;
                }

                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');
                if (selecteds.length == 2) {
                    parent = selecteds[1];
                }

                document.operationForm.itemCd.value = $("#searchItemCd").val();
                $.ajax({
                    url : "<c:url value='/getOperationListData.do'/>",
                    type : 'POST',
                    data : $('#operationForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#operationListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\">";
                            html += "<input type=\"radio\" name=\"operRadioBox\" value=\""+val.operSeq+"\"/>";
                            html += "<div id=\"itemCd_"+val.operSeq+"\" style=\"display:none;\">" + $("#searchItemCd").val() + "</div>";
                            html += "<div id=\"operUpcdSeq_"+val.operSeq+"\" style=\"display:none;\">" + parent + "</div>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.operCd + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + val.operNm + "</span></td>";
                            html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.operRnm, "") + "</span></td>";
                            html += "</tr>";
                            $("#operationListBody").append(html);
                        });
                        $('#addOperationModal').css("display", "block");
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            });

            $('#btnAddBom').click(function() {
                if ($("input:radio[name=operRadioBox]:checked").val() == '') {
                    alert("추가 대상 공정을 선택해 주세요");
                    return false;
                }

                document.bomForm.itemCd.value = $('#itemCd_' + $("input:radio[name=operRadioBox]:checked").val()).html();
                document.bomForm.operSeq.value = $("input:radio[name=operRadioBox]:checked").val();
                document.bomForm.operUpcdSeq.value = $('#operUpcdSeq_' + $("input:radio[name=operRadioBox]:checked").val()).html();
                document.bomForm.bomTypeCd.value = 'OP';
                document.bomForm.confirmYn.value = 'N';

                $.ajax({
                    url : "<c:url value='/bomCreateAct.do'/>",
                    type : 'POST',
                    data : $('#bomForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        cfAlert('생성 되었습니다.');
                        $('.modal-container').css("display", "none");
                        getBomTreeData(true);
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            });
            // 팝업 닫기
            $('.modal-close-button').click(function() {
                $('.modal-container').css("display", "none");
            });

            //-------------------------------------------------------------
            // BOM 삭제
            //-------------------------------------------------------------
            $('#btnBomDelete').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("삭제 대상 BOM을 선택해 주세요");
                    return false;
                }

                var selected = parent[0];
                var selecteds = selected.split('|');
                if (selecteds.length != 2) {
                    alert("삭제 대상 공정을 선택해 주세요");
                    return false;
                }

                document.searchForm.searchItemCd.value = selecteds[0];
                document.bomForm.operSeq.value = selecteds[1];
                document.bomForm.itemCd.value = $("#searchItemCd").val();

                $("#glv_del_confirm").dialog("open");
            });

            $("#glv_del_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "확인",
                    click : function() {
                        $(this).dialog("close");

                        $.ajax({
                            url : "<c:url value='/deleteBomTree.do'/>",
                            type : 'POST',
                            data : $('#bomForm').serialize(),
                            contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                            context : this,
                            dataType : 'json',
                            beforeSend : function() {
                                $("#layoutSidenav").loading();
                            },
                            success : function(data) {
                                cfAlert('삭제 되었습니다.');
                                getBomTreeData(true);
                            },
                            error : function(request, status, error) {
                                console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                                cfAlert('시스템 오류입니다.');
                            },
                            complete : function() {
                                $("#layoutSidenav").loadingClose();
                            }
                        });
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // 소요 자재 추가
            //-------------------------------------------------------------
            var MAT_DATA_LIST;

            getMatData = function() {
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("자재를 추가할 공정을 선택하세요.");
                    return false;
                }
                if (selecteds.length == 2) {
                    parent = selecteds[1];
                }

                document.matForm.searchItemCd.value = selecteds[0];

                $.ajax({
                    url : "<c:url value='/getMatListData.do'/>",
                    type : 'POST',
                    data : $('#matForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#matListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        MAT_DATA_LIST = data;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            var matObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\" style=\"width: 7%;\">";
                            html += "<input type=\"radio\" id=\"matRadioBox_"+key+"\" name=\"matRadioBox\" value=\""+key+"\"/>";
                            html += "<input type=\"hidden\" id=\"matCd_"+key+"\" name=\"matCd\" value=\""+val.matCd+"\"/>";
                            html += "<input type=\"hidden\" id=\"operSeq_"+key+"\" name=\"operSeq\" value=\""+parent+"\"/>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 40%;\"><span>" + val.matNm + "</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 25%;\"><input type=\"text\" class=\"input_number\" id=\"demandQty_" + key + "\" name=\"demandQty\" value=\"0\" onKeyUp=\"javascript:onKeyUpEvent(this);\"/></td>";
                            html += "</tr>";
                            $("#matListBody").append(html);
                        });
                        $('#addMatModal').css("display", "block");
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                        $(".input_number").unbind().click(function() {
                            this.select();
                        });
                    }
                });
            };
            //-------------------------------------------------------------
            // 검사 항목 추가
            //-------------------------------------------------------------
            getInspItemData = function(type) {
                document.inspItemForm.searchInspTypeCd.value = type;
                document.inspItemForm.searchOperSeq.value = GLV_OPER_SEQ;
                document.bomInspItemForm.inspTypeCd.value = type;

                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');
                if (selecteds.length != 2) {
                    alert("검사항목 추가 대상 공정을 선택하세요.");
                    return false;
                }
                if (selecteds.length == 2) {
                    parent = selecteds[1];
                }
                document.inspItemForm.searchItemCd.value = selecteds[0];

                $.ajax({
                    url : "<c:url value='/getInspItemData.do'/>",
                    type: 'POST',
                    data: $('#inspItemForm').serialize(),
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    context:this,
                    dataType:'json',
                    beforeSend:function(){
                        $("#inspItemListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success: function(data) {
                        MAT_DATA_LIST = data;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val){
                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\" style=\"width: 7%;\">";
                            html += "<input type=\"checkbox\" id=\"inspItemCheckBox_"+key+"\" name=\"inspItemCheckBox\" value=\""+key+"\"/>";
                            html += "</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 10%;\">"+val.inspTypeNm+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 20%;\">"+val.inspItemCd+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 20%;\">"+val.inspItemNm+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 12%;\">"+val.inspItemTypeNm+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 12%;\">"+cfIsNullString(val.lowVal)+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 12%;\">"+cfIsNullString(val.highVal)+"</td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 7%;\">"+cfIsNullString(val.inspDanwiCd)+"</td>";
                            html += "</tr>";
                            $("#inspItemListBody").append(html);
                        });
                        $('#addInspItemModal').css("display", "block");
                    },
                    error: function(request, status, error){
                        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete:function(){
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            $('#btnAddMatList').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("자재 추가 대상 공정을 선택해 주세요");
                    return false;
                }
                getMatData();
            });

            $('#btnAddJjInspItem').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사항목 추가 대상 공정을 선택해 주세요");
                    return false;
                }
                getInspItemData('JJ');
            });
            $('#btnAddPtInspItem').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사항목 추가 대상 공정을 선택해 주세요");
                    return false;
                }
                getInspItemData('PT');
            });


            $(document).on('click', 'input[name=matRadioBox]', function() {
                $.each(MAT_DATA_LIST.rtn.obj, function(key, val) {
                    $('#demandQty_' + key).attr("readonly", true);
                    $('#matAppVal_' + key).attr("readonly", true);
                    $('#confirmQty_' + key).attr("readonly", true);
                    $('#remainQty_' + key).attr("readonly", true);
                });

                $('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).attr("readonly", false);
                $('#matAppVal_' + $("input:radio[name=matRadioBox]:checked").val()).attr("readonly", false);
                $('#confirmQty_' + $("input:radio[name=matRadioBox]:checked").val()).attr("readonly", false);
                $('#remainQty_' + $("input:radio[name=matRadioBox]:checked").val()).attr("readonly", false);
            });

            $(document).on('change', '#matListBody tr', function() {
                var tr = $(this);
                var td = tr.children();
                if (!cfCheckDigit(td.eq(3).children().children().val())) {
                    return false;
                }
                if (!cfCheckDigit(td.eq(4).children().children().val())) {
                    return false;
                }
                td.eq(5).children().children().val(Number(td.eq(3).children().children().val()) + Number(td.eq(4).children().children().val()));
            });
            
            
           //-------------------------------------------------------------
           // 소재 row 클릭 라디오 박스 선택 
           //-------------------------------------------------------------
           $(document).on('click','#matListBody tr',function(){
               var radioBox = $(this).children().find("input[name='matRadioBox']");
               radioBox.prop('checked', true);
           });

            calcConfirmQty = function(pos) {
                if (!cfCheckDigit($('#demandQty_' + pos).val())) {
                    return false;
                }
                if (!cfCheckDigit($('#matAppVal_' + pos).val())) {
                    return false;
                }
                $('#confirmQty_' + pos).val(Number($('#demandQty_' + pos).val()) + Number($('#matAppVal_' + pos).val()));
            };

            $('#btnAddInspItem').click(function() {
                //선택 loop
                $('input:checkbox[name=inspItemCheckBox]:checked').each(function () {
                     document.bomInspItemForm.searchItemCd.value = $("#searchItemCd").val();
                     document.bomInspItemForm.searchOperSeq.value = GLV_OPER_SEQ;
                     document.bomInspItemForm.inspItemCd.value = $("#inspItemListBody tr").eq($(this).val()).children().eq(2).html();

                     $.ajax({
                         url : "<c:url value='/bomInspItemCreateAct.do'/>",
                         type: 'POST',
                         data: $('#bomInspItemForm').serialize(),
                         async: false,
                         contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                         context:this,
                         dataType:'json',
                         beforeSend:function(){
                             $("#layoutSidenav").loading();
                         },
                         success: function(data) {
                             cfAlert('생성 되었습니다.');
                             $('.modal-container').css("display", "none");
                         },
                         error: function(request, status, error){
                             console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                             cfAlert('시스템 오류입니다.');
                         },
                         complete:function(){
                             $("#layoutSidenav").loadingClose();
                         }
                     });
                });

                //저장후 재검색  async: false, 적용
                drawjjInspItemList(GLV_OPER_SEQ);
                drawptInspItemList(GLV_OPER_SEQ);
            });
            $('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).on("keyup", function(event) {
                $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            });

            $('#btnAddMat').click(function() {
                if (cfIsNull($("input:radio[name=matRadioBox]:checked").val())) {
                    alert("자재를 선택해 주세요");
                    return false;
                }
                if ($('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).val() == ''||$('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).val() == 0) {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 소요량"));
                    $('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).focus();
                    return false;
                }

                if (!cfCheckDigit($('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).val())) {
                    alert(MSG_COM_ERR_008.replace("[@]", " : 소요량"));
                    $('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).focus();
                    return false;
                }

                document.bomForm.itemCd.value = $("#searchItemCd").val();
                document.bomForm.operSeq.value = $('#operSeq_' + $("input:radio[name=matRadioBox]:checked").val()).val();
                document.bomForm.bomTypeCd.value = 'MT';
                document.bomForm.matCd.value = $('#matCd_' + $("input:radio[name=matRadioBox]:checked").val()).val();
                document.bomForm.demandQty.value = $('#demandQty_' + $("input:radio[name=matRadioBox]:checked").val()).val();
                document.bomForm.confirmYn.value = 'N';

                $.ajax({
                    url : "<c:url value='/bomCreateAct.do'/>",
                    type : 'POST',
                    data : $('#bomForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        drawBomMatList(GLV_OPER_SEQ);
                        cfAlert('생성 되었습니다.');
                        $('.modal-container').css("display", "none");
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            });

            //-------------------------------------------------------------
            // 소요 자재 삭제
            //-------------------------------------------------------------
            $('#btnDelMatList').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("자재 삭제 대상 공정을 선택해 주세요");
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("자재 삭제 대상 공정을 선택하세요.");
                    return false;
                }

                if (cfIsNull($("input:radio[name=bomMatRadioBox]:checked").val())) {
                    alert("삭제 대상 자재를 선택해 주세요");
                    return false;
                }

                $("#mat_del_confirm").dialog("open");
            });

            $("#mat_del_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "확인",
                    click : function() {
                        $(this).dialog("close");
                        document.bomForm.bomSeq.value = $("input:radio[name=bomMatRadioBox]:checked").val();
                        $.ajax({
                            url : "<c:url value='/deleteBomMat.do'/>",
                            type : 'POST',
                            data : $('#bomForm').serialize(),
                            contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                            context : this,
                            dataType : 'json',
                            beforeSend : function() {
                                $("#layoutSidenav").loading();
                            },
                            success : function(data) {
                                cfAlert('삭제 되었습니다.');
                                drawBomMatList(GLV_OPER_SEQ);
                            },
                            error : function(request, status, error) {
                                console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                                cfAlert('시스템 오류입니다.');
                            },
                            complete : function() {
                                $("#layoutSidenav").loadingClose();
                            }
                        });
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });
            //-------------------------------------------------------------
            // 검사 항목 삭제
            //-------------------------------------------------------------
            $('#btnDelJjInspItem').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사 항목 삭제 대상 공정을 선택해 주세요");
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("검사 항목 삭제 대상 공정을 선택하세요.");
                    return false;
                }
                if (cfIsNull($("input:checkbox[name=bomInspItemRadioBox]:checked").val())) {
                    alert("삭제 대상 검사항목을 선택해 주세요");
                    return false;
                }

                $('input:checkbox[name=bomInspItemRadioBox]:checked').each(function () {
                   var bomInspSeq = $(this).val();
                    document.bomInspItemForm.bomInspSeq.value = bomInspSeq;
                    $.ajax({
                         url : "<c:url value='/deleteBomInspItem.do'/>",
                         type: 'POST',
                         data: $('#bomInspItemForm').serialize(),
                         async: false,
                         contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                         context:this,
                         dataType:'json',
                         beforeSend:function(){
                             $("#layoutSidenav").loading();
                         },
                         success: function(data) {
                             cfAlert('삭제 되었습니다.');
                             $('.modal-container').css("display", "none");
                         },
                         error: function(request, status, error){
                             console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                             cfAlert('시스템 오류입니다.');
                         },
                         complete:function(){
                             $("#layoutSidenav").loadingClose();
                         }
                     });
                });
                //저장후 재검색  async: false, 적용
                drawjjInspItemList(GLV_OPER_SEQ);
            });

            $('#btnDelPtInspItem').click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사 항목 삭제 대상 공정을 선택해 주세요");
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("검사 항목 삭제 대상 공정을 선택하세요.");
                    return false;
                }
                if (cfIsNull($("input:checkbox[name=bomInspPtItemRadioBox]:checked").val())) {
                    alert("삭제 대상 검사항목을 선택해 주세요");
                    return false;
                }

                $('input:checkbox[name=bomInspPtItemRadioBox]:checked').each(function () {
                    var bomInspSeq = $(this).val();

                    document.bomInspItemForm.bomInspSeq.value = bomInspSeq;
                    $.ajax({
                         url : "<c:url value='/deleteBomInspItem.do'/>",
                         type: 'POST',
                         data: $('#bomInspItemForm').serialize(),
                         async: false,
                         contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                         context:this,
                         dataType:'json',
                         beforeSend:function(){
                             $("#layoutSidenav").loading();
                         },
                         success: function(data) {
                             cfAlert('삭제 되었습니다.');
                             $('.modal-container').css("display", "none");
                         },
                         error: function(request, status, error){
                             console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                             cfAlert('시스템 오류입니다.');
                         },
                         complete:function(){
                             $("#layoutSidenav").loadingClose();
                         }
                     });
                });
                //저장후 재검색  async: false, 적용
                drawptInspItemList(GLV_OPER_SEQ);
            });
          //-------------------------------------------------------------
            // 검사 항목 저장(자주)
            //-------------------------------------------------------------
            $("#btnSaveJjInspItem").click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사 항목 수정 대상 공정을 선택해 주세요");
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("검사 항목 수정 대상 공정을 선택하세요.");
                    return false;
                }
                if (cfIsNull($("input:checkbox[name=bomInspItemRadioBox]:checked").val())) {
                    alert("수정 대상 검사항목을 선택해 주세요");
                    return false;
                }

                //선택 loop
                $('input:checkbox[name=bomInspItemRadioBox]:checked').each(function () {
                    var bomInspSeq = $(this).val();
                    var highVal    = $("#highVal_"+bomInspSeq).val();
                    var lowVal     = $("#lowVal_"+bomInspSeq).val();

                    if(parseFloat(highVal) < parseFloat(lowVal)) {
                          alert("하한값이 상한값 보다 큽니다.");
                          return false;
                    }

                    var bomSeq     = $("#bomSeq_"+bomInspSeq).val();
                    var inspTypeCd = $("#inspTypeCd_"+bomInspSeq).val();
                    var inspItemCd = $("#inspItemCd_"+bomInspSeq).val();

                    var useYn      = "Y";

                    $.ajax({
                        url : "<c:url value='/saveBomInspItem.do'/>",
                        type: 'POST',
                        data: {"bomInspSeq":bomInspSeq,"bomSeq":bomSeq,"inspTypeCd":inspTypeCd,"inspItemCd":inspItemCd,"highVal":highVal,"lowVal":lowVal,"useYn":useYn},
                        async: false,
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            cfAlert('수정 되었습니다.');
                            $('.modal-container').css("display", "none");
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                });

                //저장후 조회 async: false,
                drawjjInspItemList(GLV_OPER_SEQ);
            });

            //-------------------------------------------------------------
            // 검사 항목 저장(패트롤)
            //-------------------------------------------------------------
            $("#btnSavePtInspItem").click(function() {
                var parent = $('#jstree').jstree('get_selected');
                if (parent == '') {
                    alert("검사 항목 수정 대상 공정을 선택해 주세요");
                    return false;
                }
                var tmpParent = $('#jstree').jstree('get_selected');
                var parent = '';
                var selected = tmpParent[0];
                var selecteds = selected.split('|');

                if (selecteds.length != 2) {
                    alert("검사 항목 수정 대상 공정을 선택하세요.");
                    return false;
                }
                if (cfIsNull($("input:checkbox[name=bomInspPtItemRadioBox]:checked").val())) {
                    alert("수정 대상 검사항목을 선택해 주세요");
                    return false;
                }

                //선택 loop
                $('input:checkbox[name=bomInspPtItemRadioBox]:checked').each(function () {
                    var bomInspSeq  = $(this).val();

                    var highVal    = $("#highVal_"+bomInspSeq).val();
                    var lowVal     = $("#lowVal_"+bomInspSeq).val();

                    if(parseFloat(highVal) < parseFloat(lowVal)) {
                          alert("하한값이 상한값 보다 큽니다.");
                          return false;
                    }

                    var bomSeq     = $("#bomSeq_"+bomInspSeq).val();
                    var inspTypeCd = $("#inspTypeCd_"+bomInspSeq).val();
                    var inspItemCd = $("#inspItemCd_"+bomInspSeq).val();
                    var useYn      = "Y";

                    $.ajax({
                        url : "<c:url value='/saveBomInspItem.do'/>",
                        type: 'POST',
                        data: {"bomInspSeq":bomInspSeq,"bomSeq":bomSeq,"inspTypeCd":inspTypeCd,"inspItemCd":inspItemCd,"highVal":highVal,"lowVal":lowVal,"useYn":useYn},
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            cfAlert('수정 되었습니다.');
                            $('.modal-container').css("display", "none");
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                });

                //저장후 조회 async: false,
                drawptInspItemList(GLV_OPER_SEQ);
            });


            //-------------------------------------------------------------
            // BOM 확정
            //-------------------------------------------------------------
            $('#btnConfirmBom').click(function() {
                if ($("#searchItemCd").val().trim() == '') {
                    alert("제품을 선택해 주세요");
                    $("#searchItemCd").focus();
                    return false;
                }
                $("#bom_confirm").dialog("open");
            });

            $("#bom_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "확인",
                    click : function() {
                        $(this).dialog("close");
                        document.bomForm.itemCd.value = $("#searchItemCd").val();
                        document.bomForm.bomBigo.value = $("#popBomBigo").val();

                        $.ajax({
                            url : "<c:url value='/confirmBomAct.do'/>",
                            type : 'POST',
                            data : $('#bomForm').serialize(),
                            contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                            context : this,
                            dataType : 'json',
                            beforeSend : function() {
                                $("#layoutSidenav").loading();
                            },
                            success : function(data) {
                                cfAlert('확정 되었습니다.');
                                drawBomHistoryList();
                            },
                            error : function(request, status, error) {
                                console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                                cfAlert('시스템 오류입니다.');
                            },
                            complete : function() {
                                $("#layoutSidenav").loadingClose();
                            }
                        });
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                $("#tabs").tabs();
                getBomTreeData(false);
            });

            //-------------------------------------------------------------
            // drawTree
            //-------------------------------------------------------------
            getBomTreeData = function(isRefresh) {
                $.ajax({
                    url : "<c:url value='/getBomTreeData.do'/>",
                    type : 'POST',
                    data : $('#searchForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (isRefresh) {
                            $('#jstree').jstree(true).settings.core.data = data.treeData;
                            $('#jstree').jstree('open_all');
                        } else {
                            drawTree(data.treeData);
                        }

                        $('#jstree').jstree(true).refresh();
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            getItemData = function() {
                $.ajax({
                    url : "<c:url value='/getItemListData.do'/>",
                    type : 'POST',
                    data : $('#itemSearchForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {
                        $("#itemListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            var itemObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            //html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>"+val.itemNo+"</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 25%;\"><span>" + cfIsNullString(val.matgpNm) + "</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 25%;\"><span>" + cfIsNullString(val.itmgpNm) + "</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 35%;\"><span><a href=\"javascript:fn_sel_item(eval(" + itemObj + "))\">" + val.itemNm + "</a></span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width: 15%;\"><span>" + cfIsNullString(val.itemTypeNm) + "</span></td>";
                            html += "</tr>";

                            $("#itemListBody").append(html);
                        });

                        $('#selItemModal').css("display", "block");

                        document.itemSearchForm.sortType.value = data.search.sortType;
                        document.itemSearchForm.sortCol.value = data.search.sortCol;

                        if (data.search.sortType == 'asc') {
                            $("#" + data.search.sortCol).attr('class', 'sorting_asc');
                        } else {
                            $("#" + data.search.sortCol).attr('class', 'sorting_desc');
                        }
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            drawTree = function(treeData) {
                $('#jstree').jstree({
                    "core" : {
                        "animation" : 0,
                        "check_callback" : false,
                        "themes" : {
                            "stripes" : true
                        },
                        "data" : treeData
                    },
                    "plugins" : [ "search", "state", "types", "wholerow", "html_data" ]
                }).bind("refresh.jstree", function() {
                    $.each($("#jstree").jstree()._model.data, function(i, key) {
                        if (key.parent != undefined) {
                            if (key.parent == "#") {
                                $("#jstree").jstree("open_node", key.id);
                            } else if (key.parent == "0") {
                                $("#jstree").jstree("close_node", key.id);
                            }
                        }
                    });
                });
            };
        });
    })(jQuery);

    //=====================================================================
    // 제품선택 콜백 함수
    //=====================================================================
    function fn_sel_item(itemObj) {

        document.searchForm.searchItemCd.value = itemObj.itemCd;
        document.searchForm.viewItemNm.value = itemObj.itemNm;
        $('.modal-container').css("display", "none");

        $("#bomOperationListBody tr").remove();
        $("#bomMatListBody tr").remove();
        $("#bomHistoryListBody tr").remove();

        getBomTreeData(true);
        drawBomHistoryList();
    }

    //=====================================================================
    // JQuery on keyup 작동 안될때.
    //=====================================================================
    function onKeyUpEvent(obj) {
        obj.value = obj.value.replace(/[^0-9|\.]/g, "");
    }
    -->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
        <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp"></jsp:include>
        <div id="layoutSidenav_content">
            <main>
            <div class="container-fluid">
                <!-- ======================================================================================================================== -->
                <!-- title                                                                                                                    -->
                <!-- ======================================================================================================================== -->
                <h1 class="mt-4">BOM</h1>
                <!-- ========================================================================================================================= -->
                <!--  card 전체                                                                                                                                                                                                                                                               -->
                <!-- ========================================================================================================================= -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <!-- ============================================================================================================= -->
                            <!--  tree 영역                                                                                                                                                                                                                                    -->
                            <!-- ============================================================================================================= -->
                            <div class="col-md-3">
                                <div class="card brd_box">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form:form commandName="search" id="searchForm" name="searchForm">
                                                    <input type="hidden" name="crudType" value="R" />
                                                    <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                                                    </div>
                                                    <div style="float: right; margin: 6px 5px;">
                                                        <input type="hidden" id="searchItemCd" name="searchItemCd" value="" />
                                                        <input type="text" class="form-control input-lg radius" size="35" placeholder="제품명" id="viewItemNm" name="viewItemNm" value="" />
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div id="jstree" style="width: 100%; overflow-y: auto; overflow-x: auto; height: 500px;"></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- ============================================================================================================= -->
                                <!--  tree 버튼 영역                                                                                                                                                                            -->
                                <!-- ============================================================================================================= -->
                                <div class="card mb-4" style="margin-top: 10px;">
                                    <div class="card-body" style="padding: 0.7rem;">
                                        <!-- 생성 버튼 -->
                                        <div id="viewCreate" class="col-md-12">
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div id="btnBomCreate" class="btn btn-primary btn-block">추가</div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div id="btnBomDelete" class="btn btn-primary btn-block">삭제</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- tree 영역 end  -->
                            <!-- ============================================================================================================= -->
                            <!--  우측 탭 영역                                                                                                                                                                                -->
                            <!-- ============================================================================================================= -->
                            <div class="col-md-9">
                                <div id="tabs">
                                    <ul>
                                        <li><a href="#tabs-1" data-val="OP">공정/소요량</a></li>
                                        <li><a href="#tabs-2">자주검사항목</a></li>
                                        <li><a href="#tabs-3">패트롤검사항목</a></li>
                                        <li><a href="#tabs-4" data-val="BM">BOM 이력</a></li>
                                        <div style="width: calc(100% - 500px); float: right;">
                                            <div id="btnConfirmBom" class="btn btn-primary btn-sm mr-2" style="float: right;">BOM 확정</div>
                                        </div>
                                    </ul>
                                    <div id="tabs-1">
                                        <!-- ==================================================================================================== -->
                                        <!--  공정 ROUTING 목록                                                                                                                                                      -->
                                        <!-- ==================================================================================================== -->
                                        <div class="mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                                            <div class="card-header">
                                                <sapn class="txt20">공정 ROUTING 정보</sapn>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                                        <div class="row"></div>
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                                    <thead class="thead-dark">
                                                                        <tr role="row">
                                                                            <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">NO</th>
                                                                            <th id="oper_cd" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">공정코드</th>
                                                                            <th id="oper_nm" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">공정명</th>
                                                                            <th id="bom_ver" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">BOM VER</th>
                                                                            <th id="bom_stdt" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">BOM시작일자</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="bomOperationListBody" />
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ==================================================================================================== -->
                                        <!--  자재 소요량  목록                                                                                                                                                           -->
                                        <!-- ==================================================================================================== -->
                                        <div class="mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                                            <div class="card-header">
                                                <sapn class="txt20">자재 소요량 정보</sapn>
                                                <div id="btnAddMatList" class="btn btn-primary btn-sm mr-2" style="float: right;">자재 추가</div>
                                                <div id="btnDelMatList" class="btn btn-primary btn-sm mr-2" style="float: right;">자재 삭제</div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                                        <div class="row"></div>
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                                    <thead class="thead-dark">
                                                                        <tr role="row">
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">선택</th>
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;">자재명</th>
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">소요량</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="bomMatListBody" />
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tabs-2">
                                            <!-- ==================================================================================================== -->
                                            <!--  자주검사 항목 목록                                                                                                                                                         -->
                                            <!-- ==================================================================================================== -->
                                            <div class="mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                                                <div class="card-header">
                                                    <sapn class="txt20">자주검사 항목</sapn>
                                                    <div id="btnAddJjInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 추가</div>
                                                    <div id="btnDelJjInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 삭제</div>
                                                    <div id="btnSaveJjInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 저장</div>
                                                </div>

                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                                            <div class="row">
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                                        <thead class="thead-dark">
                                                                            <tr role="row">
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">선택</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">항목코드</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">항목명</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">타입</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">하한값</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">상한값</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="jjInspListBody"/>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tabs-3">
                                            <!-- ==================================================================================================== -->
                                            <!--  패트롤겁사 항목 목록                                                                                                                                                         -->
                                            <!-- ==================================================================================================== -->
                                            <div class="mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                                                <div class="card-header">
                                                    <sapn class="txt20">패트롤검사 항목</sapn>
                                                    <div id="btnAddPtInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 추가</div>
                                                    <div id="btnDelPtInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 삭제</div>
                                                    <div id="btnSavePtInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">검사 항목 저장</div>
                                                </div>

                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                                            <div class="row">
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                                        <thead class="thead-dark">
                                                                            <tr role="row">
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">선택</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">항목코드</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">항목명</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">타입</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">하한값</th>
                                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">상한값</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="ptInspListBody"/>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <div id="tabs-4">
                                        <!-- ==================================================================================================== -->
                                        <!--  BOM 이력  목록                                                                                                                                                           -->
                                        <!-- ==================================================================================================== -->
                                        <div class="mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                                            <div class="card-header">
                                                <sapn class="txt20">BOM 이력 목록</sapn>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                                        <div class="row"></div>
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                                    <thead class="thead-dark">
                                                                        <tr role="row">
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">NO</th>
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">BOM버젼</th>
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">BOM시작일자</th>
                                                                            <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 50%;">비고</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="bomHistoryListBody" />
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 자재 소요량  목록 end  -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- card 전제 end  -->
            </div>
            </main>
        </div>
    </div>
    <div id="addOperationModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">BOM 공정 코드 추가</div>
                <span class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                <div class="card-header">
                    <sapn class="txt20">공정 코드 목록</sapn>
                    <div id="btnAddBom" class="btn btn-primary btn-sm mr-2" style="float: right;">공정 BOM 추가</div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="row"></div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                        <thead class="thead-dark">
                                            <tr role="row">
                                                <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">선택</th>
                                                <th id="oper_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">공정코드</th>
                                                <th id="oper_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 30%;">공정명</th>
                                                <th id="oper_rnm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;">설명</th>
                                            </tr>
                                        </thead>
                                        <tbody id="operationListBody" />
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="addMatModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">소요 자재 추가</div>
                <span class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                <div class="card-header">
                    <div id="btnAddMat" class="btn btn-primary btn-sm mr-2" style="float: right;">선택 자재 추가</div>
                    <form:form commandName="search" id="matForm" name="matForm">
                        <div style="float: left; margin: 6px 5px;">
                            <input type="hidden" placeholder="자재구분코드" id="searchMatTypeCd" name="searchMatTypeCd" value="MT" />
                            <input type="hidden" placeholder="자재구분코드" id="searchItemCd" name="searchItemCd" value="" />
                            <input type="text" class="form-control input-lg radius" size="35" placeholder="자재명" id="searchMatNm" name="searchMatNm" value="" />
                        </div>
                        <div id="btnMatSearch" class="button-cr radius blue" style="float: left; margin: 6px 5px 0 -42px; position: relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                        </div>
                    </form:form>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="tb_wrap">
                                <div class="tb_box">
                                    <table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                                        <thead class="thead-dark">
                                            <tr role="row" class="odd fixed_top">
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">선택</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;">자재명</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">소요량</th>
                                            </tr>
                                        </thead>
                                        <tbody id="matListBody" />
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="addInspItemModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">검사 항목 추가</div>
                <span class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                    <div id="btnAddInspItem" class="btn btn-primary btn-sm mr-2" style="float: right;">선택 검사 항목 추가</div>
                    <form:form commandName="search" id="inspItemForm" name="inspItemForm">
                       <input type="hidden" name="searchItemCd" value=""/>
                       <input type="hidden" name="searchOperSeq" value=""/>
                       <input type="hidden" name="searchInspTypeCd" value=""/>
                       <div style="float: left; margin: 6px 5px;">
                           <input type="text" class="form-control input-lg radius" size="35" placeholder="항목명" id="searchInspItemNm" name="searchInspItemNm" value="" />
                       </div>
                       <div id="btnInspItemSearch" class="button-cr radius blue" style="float: left; margin: 6px 5px 0 -44px; position: relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                       </div>
                    </form:form>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="tb_wrap">
                                <div class="tb_box">
                                 <table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                                     <thead class="thead-dark">
                                         <tr role="row" class="odd fixed_top">
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">선택</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">검사타입구분</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">검사항목코드</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">검사항목명</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">검사방법구분</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">하한값</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">상한값</th>
                                             <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">단위</th>
                                         </tr>
                                     </thead>
                                     <tbody id="inspItemListBody"/>
                                 </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="selItemModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">제품 선택</div>
                <span class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                <div class="card-header">
                    <form:form commandName="search" id="itemSearchForm" name="itemSearchForm">
                        <input type="hidden" name="sortCol" value="item_cd" />
                        <input type="hidden" name="sortType" value="asc" />
                        <div id="btnItemSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                        </div>
                        <div style="float: right; margin: 6px 5px;">
                            <input type="text" class="form-control input-lg radius" size="35" placeholder="제품명" id="searchItemNm" name="searchItemNm" value="" />
                        </div>
                    </form:form>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="tb_wrap">
                                <div class="tb_box">
                                    <table class="table table-borderless table-borderbottom dataTable table-hover tb" id="popItemTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                                        <thead class="thead-dark">
                                            <tr role="row" class="odd fixed_top">
                                                <th id="matgp_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 22%;">대분류명</th>
                                                <th id="itmgp_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 22%;">중분류명</th>
                                                <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;">제품명</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 14%;">구분</th>
                                            </tr>
                                        </thead>
                                        <tbody id="itemListBody" />
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:form commandName="operation" id="operationForm" name="operationForm">
        <input type="hidden" name="itemCd" value="" />
    </form:form>
    <form:form commandName="bom" id="bomForm" name="bomForm">
        <input type="hidden" name="bomSeq" value="" />
        <input type="hidden" name="itemCd" value="" />
        <input type="hidden" name="operSeq" value="" />
        <input type="hidden" name="operUpcdSeq" value="" />
        <input type="hidden" name="bomTypeCd" value="" />
        <input type="hidden" name="confirmYn" value="N" />
        <input type="hidden" name="matCd" value="" />
        <input type="hidden" name="demandQty" value="" />
        <input type="hidden" name="matAppVal" value="" />
        <input type="hidden" name="confirmQty" value="" />
        <input type="hidden" name="remainQty" value="" />
        <input type="hidden" name="bomBigo" value="" />
    </form:form>
    <form:form commandName="searchBom" id="searchBomForm" name="searchBomForm">
        <input type="hidden" name="searchItemCd" value="" />
        <input type="hidden" name="searchOperSeq" value="" />
        <input type="hidden" name="searchBomTypeCd" value="" />
    </form:form>
    <form:form commandName="obj" id="bomInspItemForm" name="bomInspItemForm">
    <input type="hidden" name="bomInspSeq" value=""/>
    <input type="hidden" name="searchItemCd" value=""/>
    <input type="hidden" name="searchOperSeq" value=""/>
    <input type="hidden" name="inspTypeCd" value=""/>
    <input type="hidden" name="inspItemCd" value=""/>
</form:form>
<form:form commandName="search" id="searchBomInspForm" name="searchBomInspForm">
    <input type="hidden" name="searchBomSeq" value=""/>
    <input type="hidden" name="searchInspTypeCd" value=""/>
    <input type="hidden" name="searchOperSeq" value=""/>
    <input type="hidden" name="searchItemCd" value=""/>
</form:form>
    <form:form commandName="searchBomHistory" id="searchBomHistoryForm" name="searchBomHistoryForm">
        <input type="hidden" name="searchItemCd" value="" />
    </form:form>
    <div id="mat_del_confirm" title="확인" style="display: none;">
        <div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
            <p>삭제 하시겠습니까 ?</p>
        </div>
    </div>
    <div id="bom_insp_jj_item_del_confirm" title="확인" style="display: none;">
        <div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
            <p>삭제 하시겠습니까 ?</p>
        </div>
    </div>
    <div id="bom_insp_pt_item_del_confirm" title="확인" style="display: none;">
        <div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
            <p>삭제 하시겠습니까 ?</p>
        </div>
    </div>
    <div id="bom_confirm" title="확인" style="display: none;">
        <div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
            <p>현재 BOM 확정 하시겠습니까 ?</p>
        </div>
        <div class="row" style="margin-right: 20px; margin-left: 20px;">
            <input class="form-control" id="popBomBigo" name="popBomBigo" type="text" value="" placeholder="메모를 입력하세요" />
        </div>
    </div>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
</body>
</html>