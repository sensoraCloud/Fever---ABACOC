(load-goal '(and (on B C) (on-table A) (on F A) (on C D)))

(load-start-state (quote
    ((object B)
     (clear B)
     (on-table B)
     (object G)
     (on-table G)
     (object F)
     (on F G)
     (object E)
     (on E F)
     (object D)
     (on D E)
     (object C)
     (on C D)
     (clear C)
     (object A)
     (holding A))))
