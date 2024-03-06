import{r as l,a as i,j as e,F as U}from"./jsx-runtime-f40812bf.js";import{L as n,C as w,h as te,i as Q,I as F,j as K,k as D,b as M,m as G,n as J,o as I,f as b,d as T,p as oe,q as de,r as Z,s as me,e as ue,t as Pe,v as ie}from"./Phone-1ddf01c8.js";import{u as g,a9 as W,p as Ne,l as ne,n as he,aa as Ce,ab as ve,ac as re,ad as Ee,s as ce,A as fe,m as pe,K as Ae,a as Oe,ae as Se,af as Te,ag as ge,i as be,ah as Le}from"./index.esm-e1f47206.js";import{r as ee}from"./number-28525126.js";function ye(){const{View:u,Contact:C}=l.useContext(X),N=g(M.Settings),A=g(M.PhoneNumber),[s,E]=l.useState(null),[v,f]=u,[t,c]=C,d=g(I.APPS.PHONE.contacts),[r,p]=l.useState(!1),[o,O]=l.useState(!1);l.useEffect(()=>E(t.number),[]);const k=()=>{b("Phone",{action:"removeContact",number:t.number}).then(()=>{I.APPS.PHONE.contacts.set(d.filter(a=>a.number!==t.number)),c(null),f("Contacts")})},P=()=>{b("Phone",{action:"toggleBlock",number:t.number,blocked:!t.blocked}).then(()=>{c({...t,blocked:!t.blocked}),I.APPS.PHONE.contacts.set(d.map(a=>a.number===t.number?{...a,blocked:!a.blocked}:a))})},S=()=>{b("Phone",{action:"toggleFavourite",number:t.number,favourite:!t.favourite}).then(()=>{c({...t,favourite:!t.favourite}),I.APPS.PHONE.contacts.set(d.map(a=>a.number===t.number?{...a,favourite:!a.favourite}:a))})},y=()=>{if(!t.number||t.number.length===0)return f("Contacts");t.number===A?(M.Settings.patch({name:t.firstname,avatar:t.avatar??N.avatar}),b("setPhoneName",t.firstname),b("setSettings",M.Settings.value),p(a=>!a),I.APPS.PHONE.contacts.set(d.map(a=>a.number===t.number?{...a,...t}:a))):(t.lastname=t.lastname??"",b("Phone",{action:"updateContact",data:{...t,oldNumber:s}}).then(()=>{p(a=>!a),I.APPS.PHONE.contacts.set(d.map(a=>a.number===t.number?{...a,...t}:a)),E(t.number)}))},H=()=>{t&&w.PopUp.set({title:n("APPS.MESSAGES.SEND_LOCATION_POPUP.TITLE"),description:n("APPS.MESSAGES.SEND_LOCATION_POPUP.TEXT"),buttons:[{title:n("APPS.MESSAGES.SEND_LOCATION_POPUP.CANCEL")},{title:n("APPS.MESSAGES.SEND_LOCATION_POPUP.SEND"),cb:()=>{b("Maps",{action:"getCurrentLocation"}).then(a=>{a&&b("Messages",{action:"sendMessage",number:t.number,content:`<!SENT-LOCATION-X=${ee(a.x,2)}Y=${ee(a.y,2)}!>`,attachments:[]}).then(m=>{m?M.App.set({name:"Messages",data:{number:t.number,name:t.firstname&&K(t.firstname,t.lastname),avatar:t.avatar},view:"messages"}):T("warning","something went wrong while sending location")})})}}]})},V=l.useRef(!0);return l.useEffect(()=>{V.current&&V.current&&(E(t.number),V.current=!1,O(t.number===A))},[t]),i("div",{className:"slide left",children:[e("div",{className:"contacts-header",children:i("div",{className:"items",children:[r?e("span",{}):i("div",{className:"back",onClick:()=>{f(t.from),c(null)},children:[e("i",{className:"fal fa-chevron-left"}),n(`APPS.PHONE.${t.from.toUpperCase()}.TITLE`)]}),t.firstname&&!t.company&&e("span",{onClick:()=>{r?y():p(a=>!a)},children:r?n("APPS.PHONE.DONE"):n("APPS.PHONE.EDIT")})]})}),e("div",{className:"content",children:r?e(U,{children:i("div",{className:"contact nohover",children:[i("div",{className:"user",onClick:()=>{var a,m,h;w.Gallery.set({allowExternal:(h=(m=(a=te)==null?void 0:a.value)==null?void 0:m.AllowExternal)==null?void 0:h.Other,onSelect:L=>c({...t,avatar:L.src})})},children:[t.avatar||o&&N.avatar?e("div",{className:"profile-image bigger",style:{backgroundImage:`url(${t.avatar??N.avatar})`}}):t.firstname?e("div",{className:"profile-image bigger",children:Q(t.firstname,t.lastname)}):e(W,{}),e("span",{children:n("APPS.PHONE.EDIT")})]}),i("div",{className:"contact-info",children:[e("div",{className:"item input",children:e(F,{type:"text",placeholder:n("APPS.PHONE.CONTACTS.FIRST_NAME"),value:t.firstname,onChange:a=>c({...t,firstname:a.target.value}),maxLength:20})}),!o&&e("div",{className:"item input",children:e(F,{type:"text",placeholder:n("APPS.PHONE.CONTACTS.LAST_NAME"),value:t.lastname??"",onChange:a=>c({...t,lastname:a.target.value}),maxLength:20})})]}),e("div",{className:"contact-info",children:e("div",{className:"item input",children:e(F,{className:"phone_number",type:"number",placeholder:n("APPS.PHONE.CONTACTS.PHONE_NUMBER"),defaultValue:t==null?void 0:t.number,maxLength:20,disabled:o,onChange:a=>{if(o)return;let m=a.target.value.slice(-1).charCodeAt(0);m>=48&&m<=57&&a.target.value.length<=10&&c({...t,number:a.target.value})}})})}),i("div",{className:"contact-info",children:[e("div",{className:"item input",children:e(F,{className:"phone_number",type:"email",placeholder:n("APPS.PHONE.CONTACTS.EMAIL"),defaultValue:t==null?void 0:t.email,maxLength:20,disabled:o,onChange:a=>{o||a.target.value.match(/^([\w.%+-]+)@([\w-]+\.)+([\w]{2,})$/i)&&c({...t,email:a.target.value})}})}),e("div",{className:"item input",children:e(F,{type:"text",placeholder:n("APPS.PHONE.CONTACTS.ADDRESS"),defaultValue:t==null?void 0:t.address,maxLength:20,disabled:o,onChange:a=>{o||c({...t,address:a.target.value})}})})]}),!o&&e("div",{className:"contact-info",children:e("div",{className:"item red",onClick:()=>{w.PopUp.set({title:n("APPS.PHONE.CONTACTS.REMOVE_CONTACT_TITLE"),description:n("APPS.PHONE.CONTACTS.REMOVE_CONTACT_TEXT"),buttons:[{title:n("APPS.PHONE.CONTACTS.REMOVE_CONTACT_BUTTON_CANCEL")},{title:n("APPS.PHONE.CONTACTS.REMOVE_CONTACT_BUTTON_DELETE"),color:"red",cb:k}]})},children:n("APPS.PHONE.CONTACTS.DELETE_CONTACT")})})]})}):e(U,{children:i("div",{className:"contact nohover details",children:[i("div",{className:"user",children:[t.avatar||o&&N.avatar?e("div",{className:"profile-image bigger",style:{backgroundImage:`url(${o?N.avatar:t.avatar})`}}):t.firstname?e("div",{className:"profile-image bigger",children:Q(t.firstname,t.lastname)}):e(W,{}),e("div",{className:"name",children:t.firstname?K(t.firstname,t.lastname):D(t.number)})]}),i("div",{className:"actions",children:[i("div",{className:"item","data-disabled":!!(o||t.company),onClick:()=>{M.App.set({name:"Messages",data:{number:t.number,name:t.firstname&&K(t.firstname,t.lastname),avatar:t.avatar},view:"messages"})},children:[e(Ne,{}),n("APPS.PHONE.CONTACTS.MESSAGE")]}),i("div",{className:"item call","data-disabled":o,onClick:()=>{G({number:t.number,company:t.company,companylabel:t.company&&t.firstname})},children:[e(ne,{}),n("APPS.PHONE.CONTACTS.CALL")]}),i("div",{className:"item","data-disabled":!!(o||t.company),onClick:()=>{G({number:t.number,company:t.company,companylabel:t.company&&t.firstname,videoCall:!0})},children:[e(he,{}),n("APPS.PHONE.CONTACTS.VIDEO")]})]}),!t.company&&i(U,{children:[e("div",{className:"contact-info",children:i("div",{className:"item",onClick:()=>J(t.number),children:[e("div",{className:"title",children:n("APPS.PHONE.CONTACTS.MAIN")}),e("div",{className:"value",children:D(t.number)})]})}),(t.email||t.address)&&i("div",{className:"contact-info",children:[t.email&&i("div",{className:"item",onClick:()=>J(t.email),children:[e("div",{className:"title",children:n("APPS.PHONE.CONTACTS.EMAIL").toLowerCase()}),e("div",{className:"value",children:t.email})]}),t.address&&i("div",{className:"item",onClick:()=>J(t.address),children:[e("div",{className:"title",children:n("APPS.PHONE.CONTACTS.ADDRESS").toLowerCase()}),e("div",{className:"value",children:t.address})]})]}),e("div",{className:"contact-info",children:t.firstname?i(U,{children:[e("div",{className:"item",onClick:()=>{w.Share.set({type:"contact",data:{firstname:t.firstname,lastname:t.lastname,number:t.number,avatar:t.avatar??N.avatar}})},children:n("APPS.PHONE.CONTACTS.SHARE_CONTACT")}),!o&&i(U,{children:[e("div",{className:"item",onClick:()=>H(),children:n("APPS.PHONE.CONTACTS.SHARE_LOCATION")}),t.favourite?e("div",{className:"item red",onClick:()=>{S()},children:n("APPS.PHONE.CONTACTS.REMOVE_FAVORITE")}):e("div",{className:"item",onClick:()=>{S()},children:n("APPS.PHONE.CONTACTS.ADD_FAVORITE")})]})]}):e("div",{className:"item",onClick:()=>{f("NewContact")},children:n("APPS.PHONE.CONTACTS.ADD_CONTACT")})}),!o&&e("div",{className:"contact-info",children:t.blocked?e("div",{className:"item red",onClick:()=>{w.PopUp.set({title:n("APPS.PHONE.CONTACTS.UNBLOCK_NUMBER_TITLE"),description:n("APPS.PHONE.CONTACTS.UNBLOCK_NUMBER_TEXT").format({number:D(t.number)}),buttons:[{title:n("APPS.PHONE.CONTACTS.UNBLOCK_NUMBER_BUTTON_CANCEL")},{title:n("APPS.PHONE.CONTACTS.UNBLOCK_NUMBER_BUTTON_UNBLOCK"),cb:()=>{P()}}]})},children:n("APPS.PHONE.CONTACTS.UNBLOCK_CALLER")}):e("div",{className:"item red",onClick:()=>{w.PopUp.set({title:n("APPS.PHONE.CONTACTS.BLOCK_NUMBER_TITLE"),description:n("APPS.PHONE.CONTACTS.BLOCK_NUMBER_TEXT").format({number:D(t.number)}),buttons:[{title:n("APPS.PHONE.CONTACTS.BLOCK_NUMBER_BUTTON_CANCEL")},{title:n("APPS.PHONE.CONTACTS.BLOCK_NUMBER_BUTTON_BLOCK"),color:"red",cb:()=>{P()}}]})},children:n("APPS.PHONE.CONTACTS.BLOCK_CALLER")})})]})]})})})]})}function Ie(){const{View:u,viewContact:C}=l.useContext(X),N=g(M.Settings),[A,s]=u,E=g(M.PhoneNumber),v=g(I.APPS.PHONE.contacts),f=[],[t,c]=l.useState("");return i("div",{className:"slide right",children:[i("div",{className:"contacts-header",children:[i("div",{className:"items",children:[e("div",{className:"title",children:n("APPS.PHONE.CONTACTS.TITLE")}),e(Ce,{onClick:()=>{s("NewContact")}})]}),e(oe,{placeholder:n("SEARCH"),onChange:d=>c(d.target.value)})]}),i("div",{className:"content",children:[e("div",{className:"letters",children:[...Array(26)].map((d,r)=>{let p=String.fromCharCode(r+65);return e("a",{children:p},r)})}),e("div",{className:"contact nohover",onClick:()=>{C({firstname:N==null?void 0:N.name,number:E},"Contacts")},children:i("div",{className:"profile",children:[N!=null&&N.avatar?e("img",{src:N==null?void 0:N.avatar,alt:"avatar"}):e("div",{className:"profile-image",children:N==null?void 0:N.name.split(" ").map(d=>{var r;return(r=d==null?void 0:d[0])==null?void 0:r.toUpperCase()}).join("")}),i("div",{className:"profile-info",children:[e("div",{className:"name",children:N==null?void 0:N.name}),e("div",{className:"info",children:n("APPS.PHONE.CONTACTS.MY_CARD")})]})]})}),v&&i(U,{children:[v.filter(d=>K(d.firstname,d.lastname).toLowerCase().includes(t.toLowerCase())).sort((d,r)=>d.firstname.localeCompare(r.firstname)).map((d,r)=>{let p=d.firstname.charAt(0).toUpperCase();return f.includes(p)?e("div",{className:"contact border",onClick:()=>C(d,"Contacts"),children:K(d.firstname,d.lastname)}):(f.push(p),i("div",{children:[e("div",{id:p,className:`divider ${f.length==1?"no-border":""}`,children:p}),e("div",{className:"contact border",onClick:()=>C(d,"Contacts"),children:K(d.firstname,d.lastname)})]},r))}),i("div",{className:"total-contacts",children:[v.length," ",n("APPS.PHONE.CONTACTS.TITLE")]})]})]})]})}function ke(){const{viewContact:u}=l.useContext(X),C=g(I.APPS.PHONE.contacts),[N,A]=l.useState(!1);return i("div",{className:"slide right",children:[e("div",{className:"contacts-header",children:i("div",{className:"items",children:[e("div",{className:"title",children:n("APPS.PHONE.FAVOURITES.TITLE")}),e("span",{onClick:()=>A(!N),children:N?n("APPS.PHONE.DONE"):n("APPS.PHONE.EDIT")})]})}),e("div",{className:"content",children:e("div",{className:"favourite",children:C.filter(s=>s.favourite||s.company).sort((s,E)=>s.company?-1:1).map((s,E)=>{let v=K(s.firstname,s.lastname);return i("div",{className:"item",onClick:()=>{w.PopUp.set({title:n("APPS.PHONE.CALL.CALL_TITLE").format({name:v}),description:n("APPS.PHONE.CALL.CALL_TEXT").format({name:v}),buttons:[{title:n("APPS.PHONE.CALL.CALL_BUTTON_CANCEL")},{title:n("APPS.PHONE.CALL.CALL_BUTTON_CALL"),cb:()=>{G({number:s.number,company:s.company,companylabel:s.firstname})}}]})},children:[i("div",{className:"user",children:[N&&!s.company&&e(ve,{onClick:f=>{f.stopPropagation(),w.PopUp.set({title:n("APPS.PHONE.FAVOURITES.REMOVE_TITLE"),description:n("APPS.PHONE.FAVOURITES.REMOVE_TEXT"),buttons:[{title:n("APPS.PHONE.FAVOURITES.REMOVE_BUTTON_CANCEL")},{title:n("APPS.PHONE.FAVOURITES.REMOVE_BUTTON_REMOVE"),color:"red",cb:()=>{b("Phone",{action:"toggleFavourite",number:s.number,favourite:!1}).then(t=>{I.APPS.PHONE.contacts.set(C.map(c=>c.number===s.number?{...c,favourite:!c.favourite}:c))})}}]})}}),s.avatar?e("div",{className:"avatar",style:{backgroundImage:`url(${s.avatar})`}}):e("div",{className:"avatar",children:Q(s.firstname,s.lastname)}),i("div",{className:"info",children:[v,e("span",{children:D(s.number)})]})]}),e(re,{onClick:f=>{f.stopPropagation(),u(s,"Favourites")}})]},E)})})})]})}const _=[697,770,852,941],R=[1209,1336,1477,1633],ae={1:[_[0],R[0]],2:[_[0],R[1]],3:[_[0],R[2]],4:[_[1],R[0]],5:[_[1],R[1]],6:[_[1],R[2]],7:[_[2],R[0]],8:[_[2],R[1]],9:[_[2],R[2]],"*":[_[3],R[0]],0:[_[3],R[1]],"#":[_[3],R[2]]},He=[{key:"1",letters:""},{key:"2",letters:"ABC"},{key:"3",letters:"DEF"},{key:"4",letters:"GHI"},{key:"5",letters:"JKL"},{key:"6",letters:"MNO"},{key:"7",letters:"PQRS"},{key:"8",letters:"TUV"},{key:"9",letters:"WXYZ"},{key:"*",letters:""},{key:"0",letters:"+"},{key:"#",letters:""}],Y={0:2.5,12:2,17:1.75};function _e(){const{View:u,Contact:C,viewContact:N}=l.useContext(X),[A,s]=u,[E,v]=C,[f,t]=l.useState(null),[c,d]=l.useState(""),r=l.useRef(null),p=l.useRef([]),o=l.useRef(null),O=l.useRef(null),[k,P]=l.useState(2.5);l.useEffect(()=>{r.current||(r.current=new AudioContext)},[]),l.useEffect(()=>{document.addEventListener("keydown",V),document.addEventListener("keyup",a),c==="0"&&P(2.5);let m=0;for(let h=0;h<Object.keys(Y).length;h++)c.length>=parseInt(Object.keys(Y)[h])&&(m=Y[Object.keys(Y)[h]]);return P(m),()=>{document.removeEventListener("keydown",V),document.removeEventListener("keyup",a)}},[c]);const S=m=>{if(!r.current)return;const h=r.current,[L,$]=ae[m],x="sine",j=h.createOscillator();j.frequency.value=L,j.type=x;const B=h.createOscillator();B.frequency.value=$,B.type=x;const z=h.createGain();z.gain.value=.2,j.connect(z),B.connect(z),z.connect(h.destination),j.start(),B.start();const le=setTimeout(()=>{y()},1500);p.current.push([j,B,z,le])},y=async()=>{p.current.forEach(([m,h,L,$])=>{clearTimeout($);const x=r.current;x&&(clearTimeout($),L.gain.exponentialRampToValueAtTime(1e-4,x.currentTime+.1),setTimeout(()=>{m.stop(),h.stop(),m.disconnect(),h.disconnect(),L.disconnect()},100))}),o.current=null,p.current=[]},H=async m=>{m=="delete"?d(h=>h.slice(0,-1)):m.match(/^[0-9]+$/)&&d(h=>h+m),ae[m]&&(o.current&&await y(),o.current=m,S(m))},V=m=>{if(!o.current)if(m.key.match(/^[0-9]+$/))o.current=m.key,H(m.key);else switch(m.key){case"Backspace":H("delete");break;case"Enter":c.length>=3&&G({number:c});break}},a=m=>{m.key===o.current&&y()};return l.useEffect(()=>{if(c.length!==de())return t(null);t(Z(c))},[c]),e("div",{className:"slide right",children:e("div",{className:"content noscroll",children:i("div",{className:"keypad-container",children:[i("div",{className:"inputbox",children:[e("div",{className:"input",style:{fontSize:`${k}rem`},children:D(c)}),e("span",{onClick:()=>{if(d(""),f)N(f,"Keypad");else{let m=Z(c);m?(v({...m,number:c}),s("NewContact")):(v({number:c}),s("NewContact"))}},children:c.length>0&&(f?f.name:n("APPS.PHONE.KEYPAD.ADD_NUMBER"))})]}),e("div",{className:"keypad-wrapper",children:i("div",{className:"keypad",children:[He.map(m=>i("div",{onMouseDown:()=>H(m.key),onMouseUp:()=>y(),children:[m.key,m.letters&&e("span",{children:m.letters})]},m.key)),e("span",{}),e("div",{className:"call",onClick:()=>{c.length>=3&&G({number:c})},children:e(ne,{})}),e("div",{className:"delete",onMouseDown:()=>{H("delete"),O.current&&clearInterval(O.current);const m=setInterval(()=>{H("delete")},100);O.current=m},onMouseUp:()=>{O.current&&(clearInterval(O.current),O.current=null)},children:e(Ee,{})})]})})]})})})}function Re(){const{Func:u}=l.useContext(me),{View:C,Contact:N}=l.useContext(X),A=g(M.PhoneNumber),[s]=N,[E,v]=C,f=g(I.APPS.PHONE.contacts),t=g(M.Settings),[c,d]=u.TextColor;d(t.display.theme=="dark"?"#ffffff":"#000000");const[r,p]=l.useState(null),[o,O]=l.useState(!1);l.useEffect(()=>{s&&s.number&&p({...r,number:s.number})},[s]),l.useEffect(()=>{r&&O(r.firstname&&r.number!==void 0)},[r]);const k=()=>{if(r){if(!r.number||(r==null?void 0:r.number)===A)return v("Contacts");r.lastname=(r==null?void 0:r.lastname)??"",b("Phone",{action:"saveContact",data:r}).then(P=>{if(!P)return T("warning","Failed to save contact");I.APPS.PHONE.contacts.set([...f,r]),v("Contacts")})}};return i("div",{className:"slide up",children:[e("div",{className:"contacts-header",children:i("div",{className:"items",children:[e("div",{className:"back",onClick:()=>v("Contacts"),children:n("APPS.PHONE.CANCEL")}),e("span",{className:o?"":"disabled",onClick:()=>{o&&k()},children:n("APPS.PHONE.DONE")})]})}),e("div",{className:"content",children:e(U,{children:i("div",{className:"contact nohover",children:[e("div",{className:"user",onClick:()=>{var P,S,y;w.Gallery.set({allowExternal:(y=(S=(P=te)==null?void 0:P.value)==null?void 0:S.AllowExternal)==null?void 0:y.Other,onSelect:H=>p({...r,avatar:H.src})})},children:r!=null&&r.avatar?i(U,{children:[e("div",{className:"profile-image bigger transparent",style:{backgroundImage:`url(${r.avatar})`}}),e("span",{children:n("APPS.PHONE.EDIT")})]}):i(U,{children:[e(W,{className:"big"}),e("span",{className:"add",children:n("APPS.PHONE.CONTACTS.ADD_PHOTO")})]})}),i("div",{className:"contact-info",children:[e("div",{className:"item input",children:e(F,{type:"text",placeholder:n("APPS.PHONE.CONTACTS.FIRST_NAME"),onChange:P=>p({...r,firstname:P.target.value}),maxLength:20})}),e("div",{className:"item input",children:e(F,{type:"text",placeholder:n("APPS.PHONE.CONTACTS.LAST_NAME"),onChange:P=>p({...r,lastname:P.target.value}),maxLength:20})})]}),e("div",{className:"contact-info",children:e("div",{className:"item input",children:e(F,{className:"phone_number",type:"number",placeholder:n("APPS.PHONE.CONTACTS.PHONE_NUMBER"),defaultValue:s==null?void 0:s.number,maxLength:15,onChange:P=>{let S=P.target.value.slice(-1).charCodeAt(0);S>=48&&S<=57&&p({...r,number:P.target.value})}})})})]})})})]})}function we(){const{viewContact:u}=l.useContext(X),[C,N]=l.useState("all"),[A,s]=l.useState([]),E=["all","missed"],[v,f]=l.useState(0),[t,c]=l.useState(!1),[d,r]=l.useState(!1);l.useEffect(()=>{f(0),c(!1),b("Phone",{action:"getRecent",page:0,missed:C==="missed"}).then(o=>{if(!o)return T("error","Failed to get recent calls");s(o)})},[C]);const p=o=>{if(t||d)return;let O=document.querySelector("#last");if(!O)return;!ie(O)&&(r(!0),T("info","Fetching more recent calls, page: ",v+1),b("Phone",{action:"getRecent",page:v+1,missed:C==="missed"}).then(P=>{P&&P.length>0?(s(S=>[...S,...P]),r(!1),T("info","Received more recent calls, page: ",v+1),P.length<25&&c(!0)):(T("info","Received all recent calls, nothing more to fetch. Page: ",v+1),c(!0))}),f(P=>P+1))};return i("div",{className:"slide right",children:[e("div",{className:"contacts-header",children:i("div",{className:"items col",children:[e("div",{className:"selector-container",children:e("div",{className:"selector",children:E.map((o,O)=>e("div",{className:"option","data-active":C===o,onClick:()=>N(o),children:ue(o)},O))})}),e("div",{className:"title",children:n("APPS.PHONE.RECENTS.TITLE")})]})}),e("div",{className:"content",onScroll:p,children:e("div",{className:"recent-calls",children:A.map((o,O)=>{let k=A.length-1===O?"last":"",P=Z(o.number);return i("div",{id:k,className:`item${!o.called&&!o.answered?" missed":""}`,onClick:()=>{if(o.hideCallerId)return;let S;P!=null&&P.name?S=P.name:S=D(o.number),w.PopUp.set({title:n("APPS.PHONE.CALL.CALL_TITLE").format({name:S}),description:n("APPS.PHONE.CALL.CALL_TEXT").format({name:S}),buttons:[{title:n("APPS.PHONE.CALL.CALL_BUTTON_CANCEL")},{title:n("APPS.PHONE.CALL.CALL_BUTTON_CALL"),cb:()=>{G({number:o.number})}}]})},children:[e("div",{className:"user",children:o.hideCallerId?i(U,{children:[n("APPS.PHONE.CALL.NO_CALLER_ID"),e("span",{children:n("APPS.PHONE.CALL.UNKNOWN")})]}):P!=null&&P.name?i(U,{children:[P.name,e("span",{children:D(o.number)})]}):i(U,{children:[D(o.number),e("span",{children:n("APPS.PHONE.CALL.UNKNOWN")})]})}),i("div",{className:"info",children:[e("div",{className:"date",children:Pe(o.timestamp)}),e(re,{onClick:S=>{if(S.stopPropagation(),o.hideCallerId)return T("info","Call info couldn't be loaded since user called with 'No Caller ID'");P!=null&&P.name?u({...P,number:o.number},"Recents"):u({...o},"Recents")}})]})]},O)})})})]})}const se=ce(null),q=ce([]);function Me(){const u=g(q),[C,N]=l.useState(0),[A,s]=l.useState(!1),[E,v]=l.useState(!1);l.useEffect(()=>{N(0),s(!1),b("Phone",{action:"getVoiceMails",page:0}).then(t=>{if(!t)return T("error","Failed to get voicemails");T("info","Received voicemails",t),q.set(t)})},[]);const f=()=>{if(A||E)return;let t=document.querySelector("#last");if(!t)return;!ie(t)&&(v(!0),T("info","Fetching more voicemails, page: ",C+1),b("Phone",{action:"getVoiceMails",page:C+1}).then(d=>{d&&d.length>0?(q.set([...q.value,...d]),v(!1),T("info","Received more voicemails, page: ",C+1),d.length<25&&s(!0)):(T("info","Received all voicemails, nothing more to fetch. Page: ",C+1),s(!0))}),N(d=>d+1))};return i("div",{className:"slide right",children:[e("div",{className:"contacts-header",children:e("div",{className:"items",children:e("div",{className:"title",children:n("APPS.PHONE.VOICEMAIL.TITLE")})})}),e("div",{className:"content",onScroll:f,children:e("div",{className:"voicemails",children:u.map(t=>{let c=u[u.length-1]?"last":"";return e(Ue,{data:t,last:c},t.id)})})})]})}const Ue=({data:u,last:C})=>{const N=g(te),A=g(M.Settings),s=l.useRef(null),[E,v]=l.useState(!1),[f,t]=l.useState(!1),[c,d]=l.useState(!1),[r,p]=l.useState(null),[o,O]=l.useState(0),k=g(se),[P,S]=l.useState(null);l.useEffect(()=>{var m;s.current=new Audio(u.url),s.current.src=u.url,s.current.volume=A.sound.volume??.5,s.current.addEventListener("ended",()=>{d(!1)}),s.current.addEventListener("timeupdate",()=>{O(s.current.currentTime)});let a=(m=I.APPS.PHONE.contacts)==null?void 0:m.value;if(a&&u.number){let h=a.find(L=>L.number==u.number);h&&S(h)}return()=>{var h,L;(h=s.current)==null||h.pause(),(L=s.current)==null||L.remove(),s.current=null}},[]),l.useEffect(()=>{var a;k&&k!==u.id&&((a=s.current)==null||a.pause(),d(!1),v(!1))},[k]),l.useEffect(()=>{A.sound.volume&&(s.current.volume=A.sound.volume)},[A.sound.volume]),l.useEffect(()=>{var a;d(!1),O(0),(a=s.current)==null||a.pause(),s.current.currentTime=0,E&&se.set(u.id)},[E]);const y=a=>{a=a/1e3;const m=Math.floor(a/60),h=ee(a-m*60,0);return`${m}:${h<10?"0"+h:h}`},H=(a,m)=>{const h=new Date(a),L=h.getFullYear(),$=h.getMonth()+1,x=h.getDate(),j=h.getHours(),B=h.getMinutes();return m?`${x} ${h.toLocaleDateString(N.DateLocale,{month:"long"})} ${L} ${n("APPS.PHONE.VOICEMAIL.AT")} ${j}:${B<10?"0"+B:B}`:`${L}-${$<10?"0"+$:$}-${x<10?"0"+x:x}`},V={light:{active:"rgba(20, 20, 20, 0.7)",track:"rgba(0, 0, 0, 0.15)"},dark:{active:"rgba(255, 255, 255, 0.7)",track:"rgba(255, 255, 255, 0.2)"}};return e("div",{className:"voicemail-item",id:C,onClick:()=>v(!E),"data-expanded":E,children:i("div",{className:"voicemail-info",children:[i("div",{className:"voicemail-row",children:[i("div",{className:"details",children:[e("div",{className:"voicemail-title",children:u.hideCallerId?n("APPS.PHONE.CALL.NO_CALLER_ID"):P?K(P==null?void 0:P.firstname,P==null?void 0:P.lastname):D(u.number)}),e("div",{className:"subtitle",children:n("APPS.PHONE.CONTACTS.MAIN")}),E&&e("div",{className:"subtitle",children:H(u.timestamp,!0)})]}),!E&&i("div",{className:"info",children:[e("div",{className:"date",children:H(u.timestamp)}),e("div",{className:"duration",children:y(u.duration)})]})]}),e(fe,{children:E&&i(pe.div,{className:"voicemail-actions",initial:{opacity:0,height:0},animate:{opacity:1,height:"auto"},exit:{opacity:0,height:0},children:[i("div",{className:"voicemail-duration-slider",onClick:a=>a.stopPropagation(),children:[e(F,{type:"range",min:0,max:100,value:r||o/u.duration*100,style:{background:`linear-gradient(to right, ${V[A.display.theme].active} 0%, ${V[A.display.theme].active} ${r||o/(u.duration/1e3)*100}%, ${V[A.display.theme].track} ${r||o/(u.duration/1e3)*100}%, ${V[A.display.theme].track} 100%)`},onMouseDown:a=>{a.stopPropagation(),t(!0)},onMouseUp:a=>{if(a.stopPropagation(),t(!1),r){if(!s.current)return T("warning","Audio ref is null");s.current.currentTime=u.duration/1e3/100*r,p(null)}},onChange:a=>{a.stopPropagation(),p(a.target.value)}}),i("div",{className:"duration",children:[e("div",{children:y(o)??"0:00"}),e("div",{children:y(u.duration)})]})]}),i("div",{className:"voicemail-item-footer",children:[e("div",{className:"play",onClick:a=>{if(a.stopPropagation(),!s.current)return T("warning","Audio ref is null");c?s.current.pause():s.current.play(),d(!c)},children:c?e(Ae,{}):e(Oe,{})}),i("div",{className:"buttons",children:[u.number&&e(ne,{className:"blue",onClick:a=>{a.stopPropagation(),w.PopUp.set({title:n("APPS.PHONE.VOICEMAIL.CALL_POPUP.TITLE"),description:n("APPS.PHONE.VOICEMAIL.CALL_POPUP.DESCRIPTION").format({number:D(u.number)}),buttons:[{title:n("APPS.PHONE.VOICEMAIL.CALL_POPUP.CANCEL")},{title:n("APPS.PHONE.VOICEMAIL.CALL_POPUP.PROCEED"),cb:()=>{G({number:u.number})}}]})}}),e(Se,{className:"red",onClick:a=>{a.stopPropagation(),w.PopUp.set({title:n("APPS.PHONE.VOICEMAIL.DELETE_POPUP.TITLE"),description:n("APPS.PHONE.VOICEMAIL.DELETE_POPUP.DESCRIPTION"),buttons:[{title:n("APPS.PHONE.VOICEMAIL.DELETE_POPUP.CANCEL")},{title:n("APPS.PHONE.VOICEMAIL.DELETE_POPUP.PROCEED"),cb:()=>{b("Phone",{action:"deleteVoiceMail",id:u.id}).then(m=>{if(!m)return T("error","Failed to delete voicemail");T("info","Deleted voicemail",u.id),q.set(q.value.filter(h=>h.id!==u.id))})}}]})}})]})]})]})})]})})};const X=l.createContext(null);function Fe(){const u=g(M.App),[C,N]=l.useState("Contacts"),[A,s]=l.useState(null),E=g(I.APPS.PHONE.contacts),v=(c,d)=>{s({...c,from:d}),N("Contact")};l.useEffect(()=>{if(E&&u!=null&&u.data)if(u.view==="contact"){let c=E==null?void 0:E.find(d=>d.number==u.data);if(!c)return;s({...c||{number:u.data},from:"Contacts"}),N("Contact")}else u.view==="newContact"&&(s({number:u.data,from:"Contacts"}),N("NewContact"))},[]);const f={Favourites:e(ke,{}),Contacts:e(Ie,{}),Recents:e(we,{}),Keypad:e(_e,{}),NewContact:e(Re,{}),Contact:e(ye,{}),Voicemail:e(Me,{})},t={Favourites:e(Te,{}),Recents:e(ge,{}),Contacts:e(W,{}),Keypad:e(be,{}),Voicemail:e(Le,{})};return i("div",{className:"phone-app-container",children:[e(X.Provider,{value:{Contact:[A,s],View:[C,N],viewContact:v},children:e("div",{className:"wrapper",children:f[C]})}),e("div",{className:"footer",children:Object.keys(t).map((c,d)=>{let r=C==c?"active":"";return i("div",{className:`item ${r}`,onClick:()=>N(c),children:[t[c],e("span",{children:n(`APPS.PHONE.${c.toUpperCase()}.TITLE`)})]},d)})})]})}export{X as PhoneContext,Fe as default};
