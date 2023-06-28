<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>

.page {
        width: 23cm !important;
        min-height: 29.7cm;
        padding: 0cm;
        margin: 1cm auto;
        background: white;
        /* border-radius: 5px; */
        /* border: 1px #D3D3D3 solid; */
        /* box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); */
     
    }
.watermark1 { 
        position:absolute;
        left: 44%;
        top:  25%;
        width: 150px; 
        min-height: 85px;  
        background-image:url('/PowerMES/resource/images/강동.png');
        opacity: 0.2;
        z-index:999;
    }
.watermark2 { 
        position:absolute;
        left: 44%;
        top:  72%;
        width: 150px; 
        min-height: 85px;  
        background-image:url('/PowerMES/resource/images/강동.png');
        opacity: 0.2;
        z-index:999;
    }
@page {
        size: A4;
        margin: 0;
    }
    
@media print
{
     body * { visibility: hidden; -webkit-print-color-adjust: exact !important;}
     
     #previewTranSpec * { visibility: visible; box-sizing: border-box; -moz-box-sizing: border-box;}
     #previewTranSpec { position: absolute; }
    
    .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    .watermark1 { 
            left: 44%;
            top:  20%;
            margin: 0;
            border: initial;
            border-radius: initial;
            width: 150px; 
            min-height: 85px;  
            box-shadow: initial;
            background: initial;
            page-break-after: always;
            background-image:url('/PowerMES/resource/images/강동.png');
            opacity: 0.2;
            z-index:999;
    }
    
     .watermark2 { 
            left: 44%;
            top:  72%;
            margin: 0;
            border: initial;
            border-radius: initial;
            width: 150px; 
            min-height: 85px;  
            box-shadow: initial;
            background: initial;
            page-break-after: always;
            background-image:url('/PowerMES/resource/images/강동.png');
            opacity: 0.2;
            z-index:999;
    }
}


.title8 {padding: 0.3rem;font-size: 0.8rem;text-align:center;}
.title9 {padding: 0.3rem;font-size: 0.9rem;text-align:center;}
.title10 {padding: 0.3rem;font-size: 1.0rem;text-align:center;}
.title8b {padding: 0.3rem;font-size: 0.8rem;font-weight: bold !important;text-align:center;}
.title9b {padding: 0.3rem;font-size: 0.9rem;font-weight: bold !important;text-align:center;}
.title10b {padding: 0.3rem;font-size: 1.0rem;font-weight: bold !important;text-align:center;}
.title11b {padding: 0.3rem;font-size: 1.1rem;font-weight: bold !important;text-align:center;}
.title12b {padding: 0.3rem;font-size: 1.2rem;font-weight: bold !important;text-align:center;}
.title13b {padding: 0.3rem;font-size: 1.3rem;font-weight: bold !important;text-align:center;}
.title15b {padding: 0.3rem;font-size: 1.5rem;font-weight: bold !important;text-align:center;}
.title20b {padding: 0.3rem;font-size: 2.0rem;font-weight: bold !important;text-align:center;}
.title25b {padding: 0.3rem;font-size: 2.5rem;font-weight: bold !important;text-align:center;}

.table-border2s {border: 2px solid black;padding: 0.1rem;}

.border-left2s {border-left: 2px solid black;}
.border-right2s {border-right: 2px solid black;}
.border-bottom2s {border-bottom: 2px solid black;}
.padding03 {padding: 0.3rem;}
</style>

<script>
    $(document).ready(function() {
        
         // 팝업 닫기
        $("#brnTranSpecModalClose").click(function() {
            $("#tranSpecModal").hide();
        });
         
         // 인쇄
        $("#btnTranSpecPrint").click(function() {
            window.print();
        });
        
        //-------------------------------------------------------------
        // 거래 명세서 출력 팝업
        //-------------------------------------------------------------
        $("#btnPrintTranSpec").click(function() {
            var chkCnt = $("input:checkbox[name=rowCheckBox]:checked").length;
            
            if( chkCnt == 0 ) {
                cfAlert("선택된 목록이 없습니다.");
                return false;
            }
            
            if( chkCnt > 7 ) {
                cfAlert("거래 명세서 출력은 7개까지만 가능합니다.");
                return false;
            }
            
            // 고객사 체크
            var custList = new Array();
            $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                var custCd = $("#"+$(this).val()+"_custCd").text();
                custList.push(custCd);
            });
            
            if( chkCnt > 1 ) {
                var chkBool = true;
                custList.forEach(function(obj, idx) {
                    if( custList[0] != obj ) {
                        chkBool = false;
                        return;
                    }
                });
                
                if( !chkBool ) {
                    cfAlert("같은 고객사끼리만 거래 명세서 출력이 가능합니다.");
                    return false;
                }
            }
            
            $("#tranSpecModal").show();
            
            // 값 초기화
            $("span[name^='dynamic-']").text("");
            
            // 회사정보조회
            $.ajax({
                url : "<c:url value='/getTranSpecCompanyData.do'/>",
                type: "POST",
//                 data: {businNo:"613-81-78865"},
//                 data: {businNo:"XXX-XX-XXXXX"},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                context:this,
                dataType:"json",
                beforeSend:function(){
                    $("#layoutSidenav").loading();
                },
                success: function(data) {
                    if(!cfCheckRtnObj(data.rtn)) return;
                    
                    $("span[name='dynamic-businNo']").text(data.rtn.obj.businNo);
                    $("span[name='dynamic-mutualNm']").text(data.rtn.obj.mutualNm);
                    $("span[name='dynamic-ceoNm']").text(data.rtn.obj.ceoNm);
                    $("span[name='dynamic-addr']").text(data.rtn.obj.addr);
                    $("span[name='dynamic-businCond']").text(data.rtn.obj.businCond);
                    $("span[name='dynamic-partsCategory']").text(data.rtn.obj.partsCategory);
                    $("span[name='dynamic-telNo']").text(data.rtn.obj.telNo);
                    $("span[name='dynamic-faxNo']").text(data.rtn.obj.faxNo);
                },
                error: function(request, status, error){
                    console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                    cfAlert('시스템 오류입니다.');
                },
                complete:function(){
                    $("#layoutSidenav").loadingClose();
                }
            });
            
            $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                var lotOutId = this.value;
                
                var custNm        = $("#"+$(this).val()+"_custNm").text();
                var itemNo        = $("#"+$(this).val()+"_itemNo").text();
                var itemNm        = $("#"+$(this).val()+"_itemNm").text();
                var itemKind    = $("#"+$(this).val()+"_itemKind").text();
                var outsideQty    = Number($("#"+$(this).val()+"_outsideQty").text());
                var itemPrice    = Number($("#"+$(this).val()+"_itemPrice").text());
                var totPrice    = Number(outsideQty) * Number(itemPrice);
                
                $("span[name='dynamic-row" + idx + "-col1']").text(itemNo);
                $("span[name='dynamic-row" + idx + "-col2']").text(itemNm);
                $("span[name='dynamic-row" + idx + "-col3']").text(cfAddComma(outsideQty));
                $("span[name='dynamic-row" + idx + "-col4']").text(cfAddComma(itemPrice));
                $("span[name='dynamic-row" + idx + "-col5']").text(cfAddComma(totPrice));
                $("span[name='dynamic-row" + idx + "-col6']").text(itemKind);
                
                $("span[name='dynamic-custNm']").text(custNm);
            });
            
            $("span[name='dynamic-deliveryDt']").text(new Date().format("yyyy-MM-dd"));
            $("#receiver").html($("#provider").html().replace("공급자", "공급받는자"));
            
        });
    });
</script>


<div id="tranSpecModal" class="modal-container">

    <div class="modal-content" >
        <div class="modal-header">
            <div class="txt20">거래 명세서 출력 정보</div>
            <span id="brnTranSpecModalClose" class="modal-close-button">×</span>
        </div>
        
        <div class="card">
        
            <div class="card-header">
                <sapn class="txt20">거래 명세서 양식</sapn>
                <div id="btnTranSpecPrint" class="btn btn-primary btn-sm mr-2" style="float: right;">출력</div>
            </div>
            
            <div id="previewTranSpec" class="card-body page">
              <div class="watermark1"></div>
              <div class="watermark2"></div>
                <div id="provider">
                    <table border="2" width="100%" class="table-border2s">
                        <tr>
                             <td colspan="2" rowspan="2" class="text-center"><span class="title9b">납품일자</span></td>
                             <td colspan="1" rowspan="2" class="text-center"><span class="title9" name="dynamic-deliveryDt"></span></td>
                             <td colspan="3" rowspan="4" class="text-center border-left2s border-right2s" style="border-bottom-color:transparent;"><span class="title25b">거래명세서</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title8">등록번호</span></td>
                             <td colspan="3" rowspan="1" class="text-center"><span class="title9" name="dynamic-businNo"></span></td>
                         </tr>
                         <tr class="">
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">상호</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-mutualNm" style="font-size: 80%;"></span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">성명</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-ceoNm"></span></td>
                             
                         </tr>
                         <tr class="">
                             <td colspan="2" rowspan="3" class="text-center"><span class="title9b">거래처명</span></td>
                             <td colspan="1" rowspan="3" class="text-center"><span class="title9" name="dynamic-custNm"></span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">주소</span></td>
                             <td colspan="3" rowspan="1" class="text-center"><span class="title9" name="dynamic-addr"></span></td>
                         </tr>
                         <tr class="">
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">업태</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-businCond"></span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">종목</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-partsCategory"></span></td>
                         </tr>
                         <tr class="">
                             <td colspan="3" rowspan="1" class="text-center border-left2s border-right2s border-bottom2s"><span class="title10" style="font-weight: 500;">[ 공급자 보관용 ]</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">Tel</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-telNo"></span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9">Fax</span></td>
                             <td colspan="1" rowspan="1" class="text-center"><span class="title9" name="dynamic-faxNo"></span></td>
                         </tr>
                         
                         
                         <tr  class="" style="border-bottom-style:double;">
                             <td colspan="1" rowspan="1" class="text-center" width="4%" ><span class="title9b">순</span></td>
                             <td colspan="2" rowspan="1" class="text-center" width="22%"><span class="title9b">품 번</span></td>
                             <td colspan="2" rowspan="1" class="text-center" width="24%"><span class="title9b">품 명</span></td>
                             <td colspan="1" rowspan="1" class="text-center" width="6%" ><span class="title9b">EA</span></td>
                             <td colspan="1" rowspan="1" class="text-center" width="10%"><span class="title9b">단 가</span></td>
                             <td colspan="2" rowspan="1" class="text-center" width="20%"><span class="title9b">공 급 가 액</span></td>
                             <td colspan="1" rowspan="1" class="text-center" width="14%"><span class="title9b">비 고</span></td>
                         </tr>
                         
                         <c:forEach var="i" begin="0" end="6">
                             <tr style="height: 45px;">
                                 <td colspan="1" rowspan="1" class="padding03 text-center"><span>${i+1}</span></td>
                                 <td colspan="2" rowspan="1" class="padding03 text-center"><span name="dynamic-row${i}-col1"></span></td>
                                 <td colspan="2" rowspan="1" class="padding03 text-center"><span name="dynamic-row${i}-col2"></span></td>
                                 <td colspan="1" rowspan="1" class="padding03 text-right" ><span name="dynamic-row${i}-col3"></span></td>
                                 <td colspan="1" rowspan="1" class="padding03 text-right" ><span name="dynamic-row${i}-col4"></span></td>
                                 <td colspan="2" rowspan="1" class="padding03 text-right" ><span name="dynamic-row${i}-col5"></span></td>
                                 <td colspan="1" rowspan="1" class="padding03 text-center"><span name="dynamic-row${i}-col6"></span></td>
                             </tr>
                        </c:forEach>
                         
                         <tr style="background-color:lightgrey;">
                             <td colspan="5" rowspan="1" class="text-center">합계</td>
                             <td colspan="1" rowspan="1"></td>
                             <td colspan="1" rowspan="1"></td>
                             <td colspan="2" rowspan="1" class="text-right"><span name="dynamic-priceSumAmt"></span></td>
                             <td colspan="1" rowspan="1"></td>
                         </tr>
                         
                         
                         <tr style="height: 45px;">
                             <td colspan="2" rowspan="1" class="text-center" width="10%">출 고 자</td>
                             <td colspan="1" rowspan="1" class="text-center" width="16%"></td>
                             <td colspan="1" rowspan="1" class="text-center" width="13%">차량번호</td>
                             <td colspan="2" rowspan="1" class="text-center" width="17%"></td>
                             <td colspan="2" rowspan="1" class="text-center" width="22%">인 수 자</td>
                             <td colspan="2" rowspan="1" class="text-right pr-4" width="22%">(인)</td>
                         </tr>
                    </table>
                </div>
                <!-- provider -->
                
                <br/>
                <hr style="border:none;border:1px dashed;"/>
                
                <div id="receiver">
                </div>
                <!-- receiver -->
                
            </div>
            <!-- previewTranSpec -->
            
        </div>
        <!-- card -->
        
    </div>
    <!-- modal-content -->
    
</div>
<!-- tranSpecModal -->
    <script>
    
    </script>