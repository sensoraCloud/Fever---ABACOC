(setq  *TEST-PROBS*
   '((SS0-1
     (next-to robot A)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm2)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-2
     (next-to robot key12)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-3
     (next-to robot dr12)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-4
     (inroom robot rm2)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-5
     (holding key12)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-6
     (locked dr12)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm2)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-7
     (next-to A B)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable A)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm1)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))

    (SS0-8
     (next-to A B)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (carriable B)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm1)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))


    (SS0-9
     (inroom key12 rm2)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (carriable B)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm1)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))


    (SS0-10
     (inroom B rm2)
     ((arm-empty)
      (dr-to-rm dr12 rm2)
      (dr-to-rm dr12 rm1)
      (connects dr12 rm2 rm1)
      (connects dr12 rm1 rm2)
      (unlocked dr12)
      (dr-open dr12)
      (is-room rm2)
      (is-room rm1)
      (is-door dr12)
      (pushable B)
      (is-object key12)
      (is-object B)
      (is-object A)
      (inroom B rm1)
      (inroom A rm1)
      (inroom key12 rm1)
      (inroom robot rm1)
      (carriable key12)
      (is-key dr12 key12)))



   ))




(setq *AUX-COMMANDS*
  '((SS0-1 (expand-all))
    (SS0-2 (expand-all))
    (SS0-3 (expand-all))
    (SS0-4 (expand-all))
    (SS0-5 (expand-all))
    (SS0-6 (expand-all))
    (SS0-7 (expand-all))
    (SS0-8 (expand-all))
    (SS0-9 (expand-all))
    (SS0-10 (expand-all))))













