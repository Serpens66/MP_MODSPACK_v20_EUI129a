ALTER TABLE Traits
  ADD GGFromBarbarians INTEGER DEFAULT 0;

INSERT INTO CustomModDbUpdates(Name, Value) VALUES('TRAITS_GG_FROM_BARBARIANS', 1);
