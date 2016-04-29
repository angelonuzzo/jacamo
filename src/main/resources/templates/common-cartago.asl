// Set of common plans for cartago

// the goal !focus_env_art is produced by the JaCaMo launcher for the agent to focus on initial artifacts
+!jcm::focus_env_art([],_).
+!jcm::focus_env_art(L,0)   <- .print("Error focusing on environment artifact ",L).

@lf_env_art[atomic]
+!jcm::focus_env_art([H|T],Try)
   <- !jcm::focus_env_art(H,Try);
      !jcm::focus_env_art(T,Try).
      
+!jcm::focus_env_art(art_env(W,H,""),Try)
   <- //.print("joining workspace ",W);
      !join_workspace(W,H).
+!jcm::focus_env_art(art_env(W,H,A),Try)
   <- //.print("focusing on artifact ",A," (at workspace ",W,")");
      !join_workspace(W,H); 
      lookupArtifact(A,AId);
      +jcm::art(W,A,AId);
      focus(AId).
-!jcm::focus_env_art(L,Try)
   <- //.print("wait a bit to focus on ",L," try #",Try);
      .wait(100);
      !jcm::focus_env_art(L,Try-1).
      
+!join_workspace(W,_) : jcm::ws(W,I) <- cartago.set_current_wsp(I).      
+!join_workspace(W,"local") <- joinWorkspace(W,I); +jcm::ws(W,I).
+!join_workspace(W,local)   <- joinWorkspace(W,I); +jcm::ws(W,I).
+!join_workspace(W,H)       <- joinRemoteWorkspace(W,H,I); +jcm::ws(W,I).