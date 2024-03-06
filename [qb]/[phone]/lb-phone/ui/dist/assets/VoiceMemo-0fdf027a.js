import{r as d,a as v,j as o,F as k}from"./jsx-runtime-f40812bf.js";import{w as U,o as O,f as I,x as _,C as D,L as h,h as T,d as f,V as F,A as H,p as j,U as R,I as x,E as L,b as B}from"./Phone-1ddf01c8.js";import{r as K}from"./number-28525126.js";import{u as w,s as W,A as G,m as J,ay as q,J as z,K as Q,a as X,L as Y,ae as Z}from"./index.esm-e1f47206.js";const $=W(null);function ie(){const E=d.useRef(null),[i,C]=d.useState(""),[S,r]=d.useState(!1),u=w(O.APPS.VOICEMEMO.voicememos);d.useEffect(()=>(U("VoiceMemo").then(t=>{t&&(E.current=t)}),O.APPS.DARKCHAT.channels.value||I("VoiceMemo",{action:"get"}).then(t=>{O.APPS.VOICEMEMO.voicememos.set(t)}),()=>{E.current&&_("VoiceMemo")}),[]);const y=(t,n)=>{var M,A;const a=(M=T.value)!=null&&M.ice?new R({config:{iceTransportPolicy:"relay",iceServers:(A=T.value)==null?void 0:A.ice}}):new R;a.on("open",p=>{I("Camera",{action:"setRecordingPeerId",peerId:p}),f("info","Listening for nearby voices")});const s=document.createElement("canvas");s.width=1,s.height=1;const c=s.captureStream(0);return a.on("call",p=>{p.answer(c),p.on("stream",l=>{f("info","Received nearby voice");const g=new Audio;g.srcObject=l,g.volume=0,g.play(),new MediaStreamAudioSourceNode(t,{mediaStream:l}).connect(n)}),p.on("close",()=>{f("info","Stopped receiving nearby voice")})}),a},b=()=>{let t=h("APPS.VOICEMEMO.DEFAULT_NAME"),n=u.map(a=>{let s=a.title;if(s.startsWith(t)){let c=s.split(" ");if(c.length>1&&/^\d+$/.test(c[c.length-1]))return parseInt(c[c.length-1])}return null}).filter(a=>a!==null).sort((a,s)=>a-s);if(n.length===0)return u.some(a=>a.title===t)?`${t} 2`:t;for(let a=0;a<n.length;a++)if(n[a]!==a+2)return`${t} ${a+2}`;return`${t} ${n[n.length-1]+1}`};return d.useEffect(()=>{var p;if(!S)return;if(!E.current)return D.PopUp.set({title:h("APPS.VOICEMEMO.NO_MICROPHONE_POPUP.TITLE"),description:h("APPS.VOICEMEMO.NO_MICROPHONE_POPUP.DESCRIPTION"),buttons:[{title:h("APPS.VOICEMEMO.NO_MICROPHONE_POPUP.OK")}]}),r(!1);const t=new AudioContext,n=new MediaStreamAudioDestinationNode(t);t.createMediaStreamSource(E.current).connect(n);let s;(p=T.value)!=null&&p.recordNearbyVoices&&(s=y(t,n));const c=new MediaRecorder(n.stream);let M=[],A=Date.now();return c.ondataavailable=l=>{M.push(l.data)},c.onstop=async()=>{let l=Date.now()-A,g=Math.round(l/1e3);const N=new Blob(M,{type:c.mimeType});s&&(s.destroy(),f("info","Destroyed peer connection"),I("Camera",{action:"endedRecording"})),t.close();const e=await F(N,l,{logger:!1});H("Audio",e).then(m=>{f("info","Uploaded media");let P=b();I("VoiceMemo",{action:"upload",data:{src:m,duration:g,title:P}}).then(V=>{if(!V)return f("warning","Failed to upload voice memo");O.APPS.VOICEMEMO.voicememos.set([{id:V,title:P,timestamp:new Date().getTime(),duration:g,src:m},...u]),f("info",`Saved voice memo ${V}`)})}).catch(m=>{f("error","Failed to upload ",m)})},c.start(),()=>{c.stop()}},[S]),v("div",{className:"voicememo-container",children:[v("div",{className:"voicememo-wrapper",children:[o("div",{className:"title",children:h("APPS.VOICEMEMO.ALL_RECORDINGS")}),o(j,{placeholder:h("SEARCH"),theme:"dark",onChange:t=>C(t.target.value)}),o("div",{className:"voicememo-items",children:u.filter(t=>t.title.toLowerCase().includes(i.toLowerCase())).sort((t,n)=>n.timestamp-t.timestamp).map(t=>o(ee,{data:t,delete:()=>O.APPS.VOICEMEMO.voicememos.set(u.filter(n=>n.id!==t.id))},t.id))})]}),o("div",{className:"voicememo-footer",children:o("div",{className:"button-record",onClick:()=>r(!S),children:o("div",{className:"button-inner","data-recording":S})})})]})}const ee=E=>{const{data:i}=E,C=w(B.Settings),S=w(O.APPS.VOICEMEMO.voicememos),r=d.useRef(null),[u,y]=d.useState(!1),[b,t]=d.useState(!1),[n,a]=d.useState(0),s=w($),[c,M]=d.useState(i.title),[A,p]=d.useState(!1),[l,g]=d.useState(null);d.useEffect(()=>(r.current=new Audio(i.src),r.current.src=i.src,r.current.volume=C.sound.volume??.5,r.current.addEventListener("ended",()=>{t(!1)}),r.current.addEventListener("timeupdate",()=>{a(r.current.currentTime)}),()=>{var e,m;(e=r.current)==null||e.pause(),(m=r.current)==null||m.remove(),r.current=null}),[]),d.useEffect(()=>{var e;s&&s!==i.id&&((e=r.current)==null||e.pause(),t(!1),y(!1))},[s]),d.useEffect(()=>{C.sound.volume&&(r.current.volume=C.sound.volume)},[C.sound.volume]),d.useEffect(()=>{t(!1),a(0),u&&$.set(i.id)},[u]);const N=e=>{const m=Math.floor(e/60),P=K(e-m*60,0);return`${m}:${P<10?"0"+P:P}`};return v("div",{className:"voicememo-item",onClick:()=>y(!u),"data-expanded":u,children:[u?o(x,{className:"voicememo-title",defaultValue:c,onClick:e=>e.stopPropagation(),onLoad:e=>{e.target.style.width=e.target.value.length+"ch"},onChange:e=>{M(e.target.value),e.target.style.width=e.target.value.length+"ch"},onBlur:e=>{I("VoiceMemo",{action:"rename",id:i.id,title:e.target.value}).then(m=>{if(!m)return f("warning","Failed to rename voice memo");O.APPS.VOICEMEMO.voicememos.set(S.map(P=>P.id===i.id?{...P,title:e.target.value}:P))})}}):o("div",{className:"voicememo-title",children:c}),u&&o("div",{className:"subtitle",children:L(i.timestamp)}),v("div",{className:"voicememo-info",children:[!u&&v(k,{children:[o("div",{className:"date",children:L(i.timestamp)}),o("div",{className:"duration",children:N(i.duration)})]}),o(G,{children:u&&v(J.div,{className:"voicememo-actions",initial:{opacity:0,height:0},animate:{opacity:1,height:"auto"},exit:{opacity:0,height:0},children:[v("div",{className:"voicememo-duration-slider",onClick:e=>e.stopPropagation(),children:[o(x,{type:"range",min:0,max:100,value:l||n/i.duration*100,style:{background:`linear-gradient(to right, rgba(255, 255, 255, 0.7) 0%, rgba(255, 255, 255, 0.7) ${l||n/i.duration*100}%, rgba(255, 255, 255, 0.1) ${l||n/i.duration*100}%, rgba(255, 255, 255, 0.1) 100%)`},onMouseDown:e=>{e.stopPropagation(),p(!0)},onMouseUp:e=>{if(e.stopPropagation(),p(!1),l){if(!r.current)return f("warning","Audio ref is null");r.current.currentTime=i.duration/100*l,g(null)}},onChange:e=>{e.stopPropagation(),g(e.target.value)}}),v("div",{className:"duration",children:[o("div",{children:N(n)??"0:00"}),o("div",{children:N(i.duration)})]})]}),v("div",{className:"voicememo-item-footer",children:[o("div",{className:"share",children:o(q,{onClick:e=>{e.stopPropagation(),D.Share.set({type:"voicememo",data:i})}})}),v("div",{className:"controls",children:[o(z,{className:"disabled"}),o("span",{onClick:e=>{if(e.stopPropagation(),!r.current)return f("warning","Audio ref is null");b?(r.current.pause(),t(!1)):(r.current.play(),t(!0))},children:b?o(Q,{}):o(X,{})}),o(Y,{className:"disabled"})]}),o("div",{className:"delete",children:o(Z,{onClick:e=>{e.stopPropagation(),D.PopUp.set({title:h("APPS.VOICEMEMO.DELETE_POPUP.TITLE"),description:h("APPS.VOICEMEMO.DELETE_POPUP.DESCRIPTION"),buttons:[{title:h("APPS.VOICEMEMO.DELETE_POPUP.CANCEL")},{title:h("APPS.VOICEMEMO.DELETE_POPUP.PROCEED"),color:"red",cb:()=>{I("VoiceMemo",{action:"delete",id:i.id}).then(m=>{if(!m)return f("warning","Failed to delete voice memo");E.delete()})}}]})}})})]})]})})]})]})};export{ie as default};
