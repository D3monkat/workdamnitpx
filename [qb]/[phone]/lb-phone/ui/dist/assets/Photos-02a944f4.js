import{r as S,a as h,F as W,j as e}from"./jsx-runtime-f40812bf.js";import{s as Y,u as _,as as le,A as $,m as z,az as ce,b as se,an as de,ai as ue,o as me,aA as Pe,aB as ve,aC as fe,c as ae,T as he,ay as ee,ae as te,aD as re,aE as Ae,aF as Se,aG as Oe,aH as ge}from"./index.esm-e1f47206.js";import{o as A,f as N,d as g,y as Ee,L as t,z as K,C as y,g as j,v as Q,D as pe,h as Ce,b as Te,O as J}from"./Phone-1ddf01c8.js";import{r as be,f as Ne}from"./number-28525126.js";const G=({src:a,showAdvanced:s})=>{const[o,u]=S.useState(null);return h(W,{children:[e("video",{src:a,crossOrigin:"anonymous",controls:!1,onMouseOver:T=>{s&&T.currentTarget.play()},onMouseOut:T=>{s&&T.currentTarget.pause()},muted:!0,loop:!0,onLoadedMetadata:T=>{u(T.currentTarget.duration)}}),o&&s&&e("div",{className:"video-duration",children:(T=>{const M=Math.floor(T/60),R=be(T-M*60,0);return`${M}:${R<10?"0"+R:R}`})(o)})]})},D=Y(null),q=[{title:t("APPS.PHOTOS.VIDEOS"),id:"videos",icon:e(ue,{}),count:0},{title:t("APPS.PHOTOS.SELFIES"),id:"selfies",icon:e(me,{}),count:0},{title:t("APPS.PHOTOS.SCREENSHOTS"),id:"screenshots",icon:e(Pe,{}),count:0},{title:t("APPS.PHOTOS.IMPORTS"),id:"imports",icon:e(ve,{}),count:0},{title:t("APPS.PHOTOS.DUPLICATES"),id:"duplicates",icon:e(fe,{}),count:0}];function Me(){const a=_(D),[s,o]=S.useState(!1),u=S.useRef(null),[E,T]=S.useState([]),[M,R]=S.useState(q);S.useEffect(()=>{A.APPS.CAMERA.albums.value&&A.APPS.CAMERA.mediaTypes.value?(T(A.APPS.CAMERA.albums.value),R(A.APPS.CAMERA.mediaTypes.value)):N("Camera",{action:"getAlbums"}).then(l=>{if(!l)return g("error","No data received from server");let b=M.map(p=>{const L=l.mediaTypes.find(m=>m.id===p.id);return L?{...p,count:L.count}:p});T(l.albums),R(b),A.APPS.CAMERA.albums.set(l.albums),A.APPS.CAMERA.mediaTypes.set(b)})},[a]),S.useEffect(()=>u!=null&&u.current?(u.current.addEventListener("wheel",l=>{l.preventDefault(),u.current.scrollLeft+=l.deltaY}),()=>{u!=null&&u.current&&(u==null||u.current.removeEventListener("wheel",l=>{l.preventDefault(),u.current.scrollLeft+=l.deltaY}))}):g("warning","Scroll container not found"),[u==null?void 0:u.current]);const H=()=>{let l="";y.PopUp.set({title:t("APPS.PHOTOS.NEW_ALBUM_POPUP.TITLE"),description:t("APPS.PHOTOS.NEW_ALBUM_POPUP.DESCRIPTION"),input:{placeholder:t("APPS.PHOTOS.NEW_ALBUM_POPUP.PLACEHOLDER"),maxCharacters:20,onChange:b=>{l=b}},buttons:[{title:t("APPS.PHOTOS.NEW_ALBUM_POPUP.CANCEL")},{title:t("APPS.PHOTOS.NEW_ALBUM_POPUP.PROCEED"),cb:()=>{N("Camera",{action:"createAlbum",title:l}).then(b=>{if(!b)return g("warning","Could not create album, id not returned");if(l.length<1)return g("warning","Input is empty, cannot create album");if(l.length>20)return g("warning","Input is too long, cannot create album");let p={title:l,id:b,cover:null,count:0};T([...E,p]),A.APPS.CAMERA.albums.value=[...E,p]})}}]})},B=l=>{if(!l)return g("warning","No album id provided, cannot remove album");y.PopUp.set({title:t("APPS.PHOTOS.REMOVE_ALBUM.TITLE").format({name:l.title}),description:t("APPS.PHOTOS.REMOVE_ALBUM.DESCRIPTION").format({name:l.title}),buttons:[{title:t("APPS.PHOTOS.REMOVE_ALBUM.CANCEL")},{title:t("APPS.PHOTOS.REMOVE_ALBUM.PROCEED"),color:"red",cb:()=>{N("Camera",{action:"deleteAlbum",id:l.id}).then(b=>{if(!b)return g("error","Could not remove album, server returned false");A.APPS.CAMERA.albums.set(E.filter(p=>p.id!==l.id)),T(E.filter(p=>p.id!==l.id))})}}]})},d=Ee(l=>{let b=l.target;for(;!b.classList.contains("album");)b=b.parentElement;let p=parseInt(b.getAttribute("data-id"));if(!p)return g("warning","Could not obtain album id from element");y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.TITLE"),cb:()=>{let L="";y.PopUp.set({title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.TITLE"),description:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.DESCRIPTION"),input:{placeholder:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.PLACEHOLDER"),minCharacters:1,maxCharacters:20,onChange:m=>{L=m}},buttons:[{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.CANCEL")},{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.PROCEED"),cb:()=>{if(L.length<1)return g("warning","Input is empty, cannot rename album");g("warning","Renaming album",p,L),N("Camera",{action:"renameAlbum",id:p,title:L}).then(m=>{if(!m)return g("error","Could not rename album, server returned false");T(E.map(P=>P.id===p?{...P,title:L}:P)),A.APPS.CAMERA.albums.set(E.map(P=>P.id===p?{...P,title:L}:P))})}}]})}},{title:t("APPS.PHOTOS.DELETE"),color:"red",cb:()=>B(E.find(L=>L.id===p))}]})});return e(W,{children:a?e($,{children:e(Ie,{})}):h(W,{children:[h("div",{className:"albums-header",children:[h("div",{className:"top",children:[e(le,{onClick:H}),e("div",{className:"edit",onClick:()=>o(!s),children:s?t("APPS.PHOTOS.DONE"):t("APPS.PHOTOS.EDIT")})]}),e("div",{className:"title",children:t("APPS.PHOTOS.ALBUMS")})]}),h("div",{className:"albums-content",children:[e("div",{className:"subtitle",children:t("APPS.PHOTOS.MY_ALBUMS")}),e("div",{className:"albums-grid","data-edit":s,ref:u,children:e($,{children:E.map((l,b)=>h(z.div,{animate:{scale:1},exit:{scale:.2},transition:{duration:.25,ease:"easeInOut"},className:"album","data-id":l.id,"data-removable":l.removable,...d,onClick:()=>{s||D.set(l)},children:[s&&l.removable!==!1&&e("div",{className:"remove",onClick:p=>{p.stopPropagation(),B(l)},children:e(ce,{})}),h("div",{className:"cover",children:[K(l.cover)?e(G,{src:l.cover,showAdvanced:!1}):e("img",{src:l.cover??"https://join.travelmanagers.com.au/wp-content/uploads/2017/09/default-placeholder-300x300.png"}),l.id==="favourites"&&e(se,{})]}),h("div",{className:"text",children:[e("div",{className:"title",children:l.title}),e("div",{className:"count",children:Ne(l.count)})]})]},b))})})]}),e("div",{className:"divider"}),h("div",{className:"media-types",children:[e("div",{className:"subtitle",children:t("APPS.PHOTOS.MEDIA_TYPES")}),e("div",{className:"media-types-items",children:M.map((l,b)=>h("div",{className:"item",onClick:()=>{if(s)return g("info","Edit mode is enabled, cannot open media type");D.set({...l,id:null,cover:null,type:l.id})},children:[h("div",{className:"type",children:[l.icon,l.title]}),h("div",{className:"action",children:[e("div",{className:"count",children:l.count}),e(de,{})]})]},b))})]})]})})}const Ie=()=>{const a=_(D),s=_(V),[o,u]=S.useState([]),[E,T]=S.useState([]),[M,R]=S.useState(!1),[H,B]=S.useState(!1),[d,l]=S.useState(!1),[b,p]=S.useState(0);S.useEffect(()=>{N("Camera",{action:"getImages",filter:{album:a.id,type:a.type}}).then(m=>{if(!m)return g("warning","No data was returned from getImages event");T(m.reverse()),R(m.length===0)})},[]);const L=m=>{if(H||d)return;let P=document.querySelector("#last");if(!P)return;!Q(P)&&(l(!0),N("Camera",{action:"getImages",page:b+1,filter:{album:a.id,type:a.type}}).then(O=>{O&&O.length>0?(T([...O.reverse(),...E]),l(!1),O.length<32&&B(!0)):B(!0)}),p(O=>O+1))};return h(z.div,{initial:{opacity:0,x:35},animate:{opacity:1,x:0},exit:{opacity:0,x:35},transition:{duration:.25,ease:"easeInOut"},children:[h("div",{className:"library-header",children:[h("div",{className:"top",children:[e("div",{className:"info",children:h("div",{className:"back",style:{color:E.length<15?"var(--phone-color-blue)":"#ffffff"},onClick:()=>{s&&V.set(!1),D.set(null)},children:[e(ae,{}),t("APPS.PHOTOS.ALBUMS")]})}),h("div",{className:"actions",style:{color:E.length<15?"var(--phone-color-blue)":"var(--phone-text-primary)"},children:[e("div",{className:"button",onClick:()=>V.set(!s),children:s?t("APPS.PHOTOS.DONE"):t("APPS.PHOTOS.SELECT")}),e("div",{className:"button round",onClick:()=>{y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.TITLE"),cb:()=>{let m="";y.PopUp.set({title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.TITLE"),description:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.DESCRIPTION"),input:{placeholder:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.PLACEHOLDER"),minCharacters:1,maxCharacters:20,onChange:P=>{m=P}},buttons:[{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.CANCEL")},{title:t("APPS.PHOTOS.RENAME_ALBUM_POPUP.PROCEED"),cb:()=>{if(m.length<1)return g("warning","Input is empty, cannot rename album");g("info","Renaming album",a.id,m),N("Camera",{action:"renameAlbum",id:a.id,title:m}).then(P=>{if(!P)return g("error","Could not rename album, server returned false");D.set({...a,title:m}),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(c=>c.id===a.id?{...c,title:m}:c))})}}]})}},{title:t("APPS.PHOTOS.DELETE"),color:"red",cb:()=>{y.PopUp.set({title:t("APPS.PHOTOS.REMOVE_ALBUM.TITLE").format({name:a.title}),description:t("APPS.PHOTOS.REMOVE_ALBUM.DESCRIPTION").format({name:a.title}),buttons:[{title:t("APPS.PHOTOS.REMOVE_ALBUM.CANCEL")},{title:t("APPS.PHOTOS.REMOVE_ALBUM.PROCEED"),color:"red",cb:()=>{N("Camera",{action:"deleteAlbum",id:a.id}).then(m=>{if(!m)return g("error","Could not remove album, server returned false");A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.filter(P=>P.id!==a.id)),D.set(null)})}}]})}}]})},children:e(he,{})})]})]}),e("div",{className:"name",style:{color:E.length<15?"var(--phone-text-primary)":"#ffffff"},children:a.title})]}),h("div",{className:"library-content","data-offset":E.length<15,onScroll:L,children:[M&&h("div",{className:"no-photos",children:[e("div",{className:"title",children:t("APPS.PHOTOS.NO_PHOTOS")}),e("div",{className:"description",children:t("APPS.PHOTOS.NO_PHOTOS_INSTRUCTIONS")})]}),!s&&a.photoCount!==void 0&&!M&&e("div",{className:"info",children:t("APPS.PHOTOS.PHOTO_COUNT").format({photos:a.photoCount,videos:a.videoCount})}),e("div",{className:"library-grid",children:E.map((m,P)=>h("div",{id:P===0?"last":"",className:"grid-item",onClick:()=>{if(s){const O=o.find(I=>I.id===m.id);u(O?o.filter(I=>I.id!==m.id):[...o,m])}else w.set({activeImage:m,images:E})},children:[m.isVideo?e(G,{src:m.src,showAdvanced:!s}):e("div",{className:"img",style:{backgroundImage:`url(${m.src})`}}),e("div",{className:"checkbox",children:s&&(o.find(O=>O.id===m.id)?e(j,{checked:!0}):e(j,{checked:!1}))})]},P))})]}),s&&h("div",{className:"select-footer",children:[e("div",{className:"icons","data-disabled":o.length===0,children:e(ee,{})}),e("div",{className:"title",children:o.length===0?t("APPS.PHOTOS.SELECT_ITEMS"):t("APPS.PHOTOS.SELECTED_COUNT").format({count:o.length})}),h("div",{className:"icons","data-disabled":o.length===0,children:[e(te,{onClick:()=>{if(o.length===0)return;let m=a.id!=="recents"&&a.id!=="favourites";y.ContextMenu.set({title:m&&t("APPS.PHOTOS.DELETE_CONTEXT_TITLE").format({type:o.length>1?t("APPS.PHOTOS.THESE_PHOTOS"):t("APPS.PHOTOS.THIS_PHOTO")}),buttons:[m&&{title:t("APPS.PHOTOS.REMOVE_FROM_ALBUM"),cb:()=>{N("Camera",{action:"removeFromAlbum",album:a.id,ids:o.map(P=>P.id)}).then(P=>{if(!P)return g("error","Could not remove from album, server returned false");let c=a.photoCount-o.filter(I=>!I.isVideo).length,O=a.videoCount-o.filter(I=>I.isVideo).length;A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(I=>{if(I.id===a.id)return{...I,count:I.count-o.length,photoCount:c,videoCount:O}})),D.set({...a,photoCount:c,videoCount:O}),T(E.filter(I=>!o.find(r=>I.id===r.id))),u([]),V.set(!1)})}},{title:t("APPS.PHOTOS.DELETE"),color:"red",cb:()=>{N("Camera",{action:"deleteFromGallery",ids:o.map(P=>P.id)}).then(P=>{if(!P)return g("error","Could not delete from gallery, server returned false");let c=0;o.forEach(r=>{c+=r.size}),window.postMessage({action:"phone:updateStorage",add:!1,size:c});let O=a.photoCount-o.filter(r=>!r.isVideo).length,I=a.videoCount-o.filter(r=>r.isVideo).length;N("Camera",{action:"getAlbums"}).then(r=>{if(!r)return g("error","No data received from server");let f=q.map(C=>{const i=r.mediaTypes.find(n=>n.id===C.id);return i?{...C,count:i.count}:C});A.APPS.CAMERA.albums.set(r.albums),A.APPS.CAMERA.mediaTypes.set(f)}),D.set({...a,photoCount:O,videoCount:I}),T(E.filter(r=>!o.find(f=>r.id===f.id))),u([]),V.set(!1)})}}]})}}),e(re,{onClick:()=>{o.length!==0&&y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.ADD_TO_ALBUM"),cb:()=>{x.set({images:o,onSelect:m=>{N("Camera",{action:"addToAlbum",album:m.id,ids:o.map(P=>P.id)}).then(P=>{if(!P)return g("error","Could not add to album, server returned false");u([]),V.set(!1),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(c=>c.id===m.id?{...c,count:c.count+o.length,photoCount:c.photoCount+o.filter(O=>!O.isVideo).length,videoCount:c.videoCount+o.filter(O=>O.isVideo).length,cover:o[o.length-1].src}:c))})}})}},{title:t("APPS.PHOTOS.ADD_TO_FAVOURITES"),cb:()=>{N("Camera",{action:"toggleFavourites",ids:o.map(m=>m.id),favourite:!0}).then(m=>{if(!m)return g("error","Could not add to favourites, server returned false");u([]),V.set(!1),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(P=>P.id==="favourites"?{...P,count:P.count+o.length,photoCount:P.photoCount+o.filter(c=>!c.isVideo).length,videoCount:P.videoCount+o.filter(c=>c.isVideo).length,cover:o[o.length-1].src}:P))})}}]})}})]})]})]})},Le=[{label:t("APPS.PHOTOS.YEARS"),value:"year"},{label:t("APPS.PHOTOS.MONTHS"),value:"month"},{label:t("APPS.PHOTOS.DAYS"),value:"day"},{label:t("APPS.PHOTOS.ALL_PHOTOS"),value:"all"}];function He(){const a=_(V),[s,o]=S.useState([]),[u,E]=S.useState([]),[T,M]=S.useState(!1),[R,H]=S.useState("all"),[B,d]=S.useState(null),[l,b]=S.useState(!1),[p,L]=S.useState(!1),[m,P]=S.useState(0),c=()=>{var oe,ne;let r=[],f=document.querySelectorAll(".grid-item");if(f.length===0||(f.forEach(F=>{!Q(F)&&r.push(F)}),r.length===0))return d(null);let C=r[0],i=parseInt(C==null?void 0:C.getAttribute("data-id"));if(!i)return;let n=(oe=u.find(F=>F.id===i))==null?void 0:oe.timestamp,v=r[r.length-1],U=parseInt(v.getAttribute("data-id")),k;if(U&&(k=(ne=u.find(F=>F.id===U))==null?void 0:ne.timestamp),!n)return;let X=O(n),ie=O(k);if(X===ie||!k)return d(X);d(`${X} - ${ie}`)},O=r=>{let f=new Date(r/1e3),C=f.toLocaleString("default",{month:"short"}),i=f.getDate(),n=f.getFullYear();return`${i} ${C} ${n}`};S.useEffect(()=>{N("Camera",{action:"getImages"}).then(r=>{if(!r)return g("warning","No data was returned from getImages event");E(r.reverse()),M(r.length===0)})},[]);const I=r=>{if(c(),l||p)return;let f=document.querySelector("#last");if(!f)return;!Q(f)&&(L(!0),N("Camera",{action:"getImages",page:m+1}).then(i=>{i&&i.length>0?(E([...i.reverse(),...u]),L(!1),i.length<32&&b(!0)):b(!0)}),P(i=>i+1))};return h(W,{children:[e("div",{className:"library-header",children:h("div",{className:"top",children:[e("div",{className:"info",children:e("div",{className:"date",style:{color:u.length<15?"var(--phone-text-primary)":"#ffffff"},children:B&&B})}),e("div",{className:"actions",children:e("div",{className:"button",onClick:()=>V.set(!a),children:a?t("APPS.PHOTOS.DONE"):t("APPS.PHOTOS.SELECT")})})]})}),e("div",{className:"library-content","data-offset":u.length<15,onScroll:I,children:e("div",{className:"library-grid","data-zoomlevel":Ue[1].toString(),children:u.map((r,f)=>h("div",{id:f===0?"last":"",className:"grid-item","data-id":r.id,onClick:()=>{if(a){const i=s.find(n=>n.id===r.id);o(i?s.filter(n=>n.id!==r.id):[...s,r])}else w.set({activeImage:r,images:u})},children:[r.isVideo?e(G,{src:r.src,showAdvanced:!a}):e("div",{className:"img",style:{backgroundImage:`url(${r.src})`}}),e("div",{className:"checkbox",children:a&&(s.find(i=>i.id===r.id)?e(j,{checked:!0}):e(j,{checked:!1}))})]}))})}),a?h("div",{className:"select-footer",children:[e("div",{className:"icons","data-disabled":s.length===0,children:e(ee,{})}),e("div",{className:"title",children:s.length===0?t("APPS.PHOTOS.SELECT_ITEMS"):t("APPS.PHOTOS.SELECTED_COUNT").format({count:s.length})}),h("div",{className:"icons","data-disabled":s.length===0,children:[e(te,{onClick:()=>{s.length!==0&&y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.DELETE"),color:"red",cb:()=>{N("Camera",{action:"deleteFromGallery",ids:s.map(r=>r.id)}).then(()=>{E(u.filter(f=>!s.find(C=>f.src===C.src))),o([]);let r=0;s.forEach(f=>{r+=f.size}),window.postMessage({action:"phone:updateStorage",add:!1,size:r}),N("Camera",{action:"getAlbums"}).then(f=>{if(!f)return g("error","No data received from server");let C=q.map(i=>{const n=f.mediaTypes.find(v=>v.id===i.id);return n?{...i,count:n.count}:i});A.APPS.CAMERA.albums.set(f.albums),A.APPS.CAMERA.mediaTypes.set(C)})})}}]})}}),e(Ae,{onClick:()=>{s.length!==0&&y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.ADD_TO_ALBUM"),cb:()=>{x.set({images:s,onSelect:r=>{N("Camera",{action:"addToAlbum",album:r.id,ids:s.map(f=>f.id)}).then(f=>{if(!f)return g("error","Could not add to album, server returned false");o([]),V.set(!1),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(C=>C.id===r.id?{...C,count:C.count+s.length,photoCount:C.photoCount+s.filter(i=>!i.isVideo).length,videoCount:C.videoCount+s.filter(i=>i.isVideo).length,cover:s[s.length-1].src}:C))})}})}},{title:t("APPS.PHOTOS.ADD_TO_FAVOURITES"),cb:()=>{N("Camera",{action:"toggleFavourites",ids:s.map(r=>r.id),favourite:!0}).then(r=>{if(!r)return g("error","Could not add to favourites, server returned false");o([]),V.set(!1),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(f=>f.id==="favourites"?{...f,count:f.count+s.length,photoCount:f.photoCount+s.filter(C=>!C.isVideo).length,videoCount:f.videoCount+s.filter(C=>C.isVideo).length,cover:s[s.length-1].src}:f))})}}]})}})]})]}):e("div",{className:"library-footer",children:Le.map((r,f)=>e("div",{className:"option","data-active":R===r.value,onClick:()=>H(r.value),children:e("div",{className:"text",children:r.label})},f))})]})}function ye(){var u,E,T;const a=_(x),s=_(A.APPS.CAMERA.albums);let o=(u=a==null?void 0:a.images)==null?void 0:u[(a==null?void 0:a.images.length)-1];return h(z.div,{initial:{opacity:0,scale:.9,y:250},animate:{opacity:1,scale:1,y:0},exit:{opacity:0,scale:.9,y:250},className:"addtoalbum-container",children:[h("div",{className:"addtoalbum-header",children:[e("div",{}),e("div",{className:"title",children:t("APPS.PHOTOS.ADD_TO_ALBUM")}),e("div",{className:"cancel",onClick:()=>x.reset(),children:t("APPS.PHOTOS.CANCEL")})]}),h("div",{className:"addtoalbum-content",children:[h("div",{className:"preview",children:[K(o==null?void 0:o.src)?e(G,{src:o==null?void 0:o.src,showAdvanced:!1}):e("img",{src:o==null?void 0:o.src}),e("div",{className:"title",children:t("APPS.PHOTOS.SELECTED_COUNT").format({count:(E=a==null?void 0:a.images)==null?void 0:E.length})})]}),e("div",{className:"albums",children:(T=s==null?void 0:s.filter(M=>M.id!=="favourites"&&M.id!=="recents"))==null?void 0:T.map((M,R)=>h("div",{className:"album",onClick:()=>{a.onSelect(M),x.reset()},children:[e("div",{className:"cover",children:K(M.cover)?e(G,{src:M.cover,showAdvanced:!1}):e("img",{src:M.cover??"https://join.travelmanagers.com.au/wp-content/uploads/2017/09/default-placeholder-300x300.png"})}),e("div",{className:"title",children:M.title}),e("div",{className:"count",children:M.count})]},R))})]})]})}function Re(){const a=_(Z),[s,o]=S.useState([{icon:e(Se,{}),title:t("APPS.PHOTOS.LIBRARY"),value:"library"},{icon:e(Oe,{}),title:t("APPS.PHOTOS.ALBUMS"),value:"albums"}]);return e("div",{className:"photos-footer",children:s.map((u,E)=>h("div",{className:"item","data-active":a===u.value,onClick:()=>{Z.set(u.value),u.value==="albums"&&a==="albums"&&(D!=null&&D.value)&&D.reset()},children:[u.icon,u.title]},E))})}const _e=()=>{var r,f,C;const a=_(Ce),s=_(Te.Settings),[o,u]=S.useState(!0),[E,T]=S.useState(!1),[M,R]=S.useState(0),H=S.useRef(null),B=S.useRef(null),d=_(w),[l,b]=S.useState(new Date(((f=(r=w==null?void 0:w.value)==null?void 0:r.activeImage)==null?void 0:f.timestamp)??0/1e3)),[p,L]=S.useState(((C=d==null?void 0:d.activeImage)==null?void 0:C.favourite)??!1),[m,P]=S.useState([]);let c=(d==null?void 0:d.images)??[];S.useEffect(()=>{if(!(d!=null&&d.activeImage))return g("warning","No active image when changing volume");if(d.activeImage.isVideo){const i=document.getElementById(d.activeImage.id);if(!i)return;i.volume=s.sound.volume}},[s.sound.volume]),S.useEffect(()=>{var n;if(!d)return;let i=c.findIndex(v=>v.id===d.activeImage.id);if(R(i),d.activeImage.isVideo){const v=document.getElementById(d.activeImage.id);if(!v)return g("warning","Video Element not found (Carousel effect)");v.play(),v.volume=s.sound.volume}if(c.length>0){let v=[];i===0?v=c.slice(0,12):i===c.length-1?v=c.slice(c.length-12,c.length):i<6?v=c.slice(0,12):i>c.length-6?v=c.slice(c.length-12,c.length):v=c.slice(i-6,i+6),b(new Date(((n=c==null?void 0:c[i])==null?void 0:n.timestamp)/1e3)),P(v)}},[d==null?void 0:d.activeImage]);const O={pos:{startLeft:0,startX:0},onMouseDown:i=>{O.pos={startLeft:H.current.scrollLeft,startX:i.clientX},H.current.style.userSelect="none",document.addEventListener("mouseup",O.onMouseUp),document.addEventListener("mousemove",O.onMove),T(!0)},onMove:i=>{if(!H.current)return;const n=(i.clientX-O.pos.startX)/J();H.current.scrollLeft=O.pos.startLeft-n;const v=H.current.getBoundingClientRect();(v.left*J()-5>i.clientX||i.clientX>v.right*J()-5)&&O.onMouseUp()},onMouseUp:()=>{if(!H.current)return;H.current.style.removeProperty("user-select"),document.removeEventListener("mouseup",O.onMouseUp),document.removeEventListener("mousemove",O.onMove);const i=H.current.clientWidth;let n=M;const v=H.current.scrollLeft-O.pos.startLeft;if(v>i/2&&n<c.length?n++:v<-i/2&&n>0&&n--,d.activeImage.id!==c[n].id&&d.activeImage.isVideo){const k=document.getElementById(d.activeImage.id);k&&(k.pause(),k.currentTime=0)}w.set({activeImage:c[n],images:c}),document.getElementById(c[n].id).scrollIntoView({behavior:"smooth",block:"center"}),T(!1)}},I=i=>{d.activeImage.isVideo&&document.getElementById(d.activeImage.id).pause(),w.set({activeImage:i,images:c}),document.getElementById(i.id).scrollIntoView({behavior:"smooth",block:"center"})};return h(z.div,{initial:{opacity:0,scale:.5},animate:{opacity:1,scale:1},exit:{opacity:0,scale:.5},className:"activephoto-container",children:[e($,{children:o&&h(z.div,{className:"photo-top",initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},transition:{duration:.2,ease:"easeInOut"},children:[e("div",{className:"back",onClick:()=>{y.Share.reset(),w.reset()},children:e(ae,{})}),h("div",{className:"date",children:[l.toLocaleString([],{day:"2-digit",month:"long"}),e("span",{children:l.toLocaleTimeString(a.DateLocale,{hour:"numeric",minute:"numeric",hour12:s.time.twelveHourClock})})]}),e("div",{children:e(re,{onClick:()=>{y.ContextMenu.set({buttons:[{title:t("APPS.PHOTOS.ADD_TO_ALBUM"),cb:()=>{x.set({images:[d.activeImage],onSelect:i=>{N("Camera",{action:"addToAlbum",album:i.id,ids:[d.activeImage.id]}).then(n=>{if(!n)return g("error","Could not add to album, server returned false");A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(v=>v.id===i.id?{...v,count:v.count+1,photoCount:d.activeImage.isVideo?v.photoCount:v.photoCount+1,videoCount:d.activeImage.isVideo?v.videoCount+1:v.videoCount,cover:d.activeImage.src}:v))})}})}},{title:t("APPS.PHOTOS.ADD_TO_FAVOURITES"),cb:()=>{N("Camera",{action:"toggleFavourites",ids:[d.activeImage.id],favourite:!0}).then(i=>{if(!i)return g("error","Could not add to favourites, server returned false");A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(n=>n.id==="favourites"?{...n,count:n.count+1,photoCount:d.activeImage.isVideo?n.photoCount:n.photoCount+1,videoCount:d.activeImage.isVideo?n.videoCount+1:n.videoCount,cover:d.activeImage.src}:n))})}}]})}})})]})}),e("div",{className:"image-overflow",ref:H,onMouseDown:O.onMouseDown,onClick:()=>{E||u(!o)},children:c==null?void 0:c.map((i,n)=>{const v=i.id===d.activeImage.id;return i.isVideo?e("video",{id:i.id,src:i.src,className:v?"active":null,crossOrigin:"anonymous",loop:!0,onLoadedMetadata:U=>{v&&(U.target.scrollIntoView({block:"center"}),U.target.play())}},n):e(pe,{id:i.id,src:i.src,className:v?"active":null,ignoreStreamerMode:!0,onLoad:U=>{v&&U.target.scrollIntoView({block:"center"})}},n)})}),e($,{children:o&&h(z.div,{className:"photo-bottom-wrapper",initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},transition:{duration:.2,ease:"easeInOut"},children:[e("div",{className:"photo-carousel",ref:B,children:m.map((i,n)=>i.isVideo?e("video",{src:i.src,"data-carousel":n,controls:!1,muted:!0,onClick:v=>I(i)},n):e("img",{src:i.src,"data-carousel":n,onClick:v=>I(i)},n))}),h("div",{className:"photo-bottom",children:[e(ee,{onClick:()=>{y.Share.set({type:"image",data:{src:d.activeImage.src,isVideo:d.activeImage.isVideo}})}}),e("div",{onClick:()=>{N("Camera",{action:"toggleFavourites",ids:[d.activeImage.id],favourite:!p}).then(i=>{if(!i)return g("warning","Failed to toggle favourite, server returned success false");L(!p),A.APPS.CAMERA.albums.set(A.APPS.CAMERA.albums.value.map(n=>n.id==="favourites"?{...n,count:p?n.count-1:n.count+1,photoCount:d.activeImage.isVideo?n.photoCount:p?n.photoCount-1:n.photoCount+1,videoCount:d.activeImage.isVideo?p?n.videoCount-1:n.videoCount+1:n.videoCount,cover:d.activeImage.src}:n))})},children:p?e(se,{}):e(ge,{})}),e(te,{onClick:()=>{y.PopUp.set({title:t("APPS.PHOTOS.DELETE_IMAGE_POPUP.TITLE"),description:t("APPS.PHOTOS.DELETE_IMAGE_POPUP.DESCRIPTION"),buttons:[{title:t("APPS.PHOTOS.DELETE_IMAGE_POPUP.CANCEL")},{title:t("APPS.PHOTOS.DELETE_IMAGE_POPUP.PROCEED"),color:"red",cb:()=>{N("Camera",{action:"deleteFromGallery",ids:[d.activeImage.id]}).then(i=>{if(!i)return g("error","Could not delete from gallery, server returned false");w.reset(),N("Camera",{action:"getAlbums"}).then(n=>{if(!n)return g("error","No data received from server");let v=q.map(U=>{const k=n.mediaTypes.find(X=>X.id===U.id);return k?{...U,count:k.count}:U});A.APPS.CAMERA.albums.set(n.albums),A.APPS.CAMERA.mediaTypes.set(v)})})}}]})}})]})]})})]})};const Z=Y("albums"),V=Y(!1),w=Y(null),x=Y(null),De={library:e(He,{}),albums:e(Me,{})},Ue=[2,3,4,5];function Fe(){const a=_(Z),s=_(w),o=_(V),u=_(x);return h("div",{className:"photos-container",children:[e("div",{className:"photos-content",style:{pointerEvents:s?"none":"all"},children:De[a]}),!o&&e(Re,{}),e($,{children:s&&e(_e,{})}),e($,{children:u&&e(ye,{})})]})}export{w as ActiveImage,x as AlbumPickerComponent,V as SelectMode,Z as View,Fe as default,Ue as zoomLevels};
