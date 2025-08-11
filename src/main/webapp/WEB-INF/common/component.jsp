<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="section">
     <section>
       <h3>[주메뉴] > [서브 메뉴]</h3>
       <h2>메뉴 제목</h2>
       <div class="filter-bar">
         <fieldset><input type="checkbox" />체크박스</fieldset>
         <select>
           <option value="부서선택" disabled selected>부서선택</option>
           <option value="경영팀">경영팀</option>
           <option value="인사팀">인사팀</option>
           <option value="재무팀">재무팀</option>
           <option value="품질관리팀">품질관리팀</option>
           <option value="판매본부">판매본부</option>
         </select>
         <input type="month" />
         <input type="date" />
         <input type="time" />
         <fieldset>
           <legend>태도 평가 점수</legend>
           <label>
             <input type="radio" name="attitudeScore" value="1" />1점
           </label>
           <label>
             <input type="radio" name="attitudeScore" value="2" />2점
           </label>
           <label>
             <input type="radio" name="attitudeScore" value="3" />3점
           </label>
           <label>
             <input type="radio" name="attitudeScore" value="4" />4점
           </label>
           <label>
             <input
               type="radio"
               name="attitudeScore"
               value="5"
               checked="checked"
             />5점
           </label>
         </fieldset>
         <input type="text" placeholder="텍스트 입력" />
         <input type="password" placeholder="비밀번호 입력" />

         <input type="submit" value="submit" />
         <button>버튼</button>
         <a href="$">a태그</a>
       </div>

       <div class="table">
         <table class="data-table">
           <tr>
             <th>사번</th>
             <th>사원명</th>
             <th>부서</th>
             <th>직급</th>
             <th>직급</th>
             <th>수정</th>
             <th>삭제</th>
           </tr>
           <tr>
             <td>"사번"</td>
             <td>"사원명"</td>
             <td>"부서"</td>
             <td>"직급"</td>
             <td>"직급"</td>
             <td><button class="innerbtn">수정</button></td>
             <td><button class="innerbtn">삭제</button></td>
           </tr>
           <tr>
             <td>"사번"</td>
             <td>"사원명"</td>
             <td>"부서"</td>
             <td>"직급"</td>
             <td>"직급"</td>
             <td><button class="innerbtn">수정</button></td>
             <td><button class="innerbtn">삭제</button></td>
           </tr>
           <tr>
             <td>"사번"</td>
             <td>"사원명"</td>
             <td>"부서"</td>
             <td>"직급"</td>
             <td>"직급"</td>
             <td><button class="innerbtn">수정</button></td>
             <td><button class="innerbtn">삭제</button></td>
           </tr>
           <tr>
             <td>"사번"</td>
             <td>"사원명"</td>
             <td>"부서"</td>
             <td>"직급"</td>
             <td>"직급"</td>
             <td><button class="innerbtn">수정</button></td>
             <td><button class="innerbtn">삭제</button></td>
           </tr>
         </table>
       </div>
       <nav>
         <ul class="pagination">
           <li class="page-item ${paging.prev ? '' : 'disabled'}">
             <a class="page-link" href="/list?page=${paging.startPage - 1}"
               >Previous</a
             >
           </li>

           <c:forEach
             begin="${paging.startPage}"
             end="${paging.endPage}"
             var="page"
           >
             <li class="page-item">
               <a
                 class="page-link ${paging.page == page ? 'active' : ''}"
                 href="/list?page=${page}"
                 >${page}</a
               >
             </li>
           </c:forEach>
           <li class="page-item ${paging.next ? '' : 'disabled'}">
             <a class="page-link" href="/list?page=${paging.endPage + 1}"
               >Next</a
             >
           </li>
         </ul>
       </nav>
     </section>