# Homework LOW

**FULL NAME:** Guessoum Mohamed Nizar.  
**Group :** 05.

----
5 commands that does not exist in XQUERY and XQUF course:

1. **zero-or-one($seq) or fn:one-or-zero($seq)** :
> Ensures the sequence has zero or one item.
```
zero-or-one((1)) → 1, but zero-or-one((1,2)) → error
```
2. **one-or-many($seq)** :
> Ensures the sequence has at least one item.
```
one-or-many(()) → error
```
3. **index-of($seq, $item)** :
> Returns positions where $item appears in $seq.
```
index-of((10,20,10), 10) → (1,3)
```
4. **reverse($seq)** :
> Reverses the sequence.
```
reverse((1,2,3)) → (3,2,1)
```
5. **subsequence($seq, $start, $length?)** :
> Extracts a portion of a sequence starting at $start (1-based). If $length is given, limits how many items.
```
subsequence((10,20,30,40), 2, 2) → (20,30)
```
6. **deep-equal($a, $b)** :
> Returns true if two sequences (or nodes) are structurally identical.
```
deep-equal((1,2), (1,2)) → true
```
7. **exists($seq)** :
> Returns true if the sequence has at least one item.
```
exists((5)) → true
```
8. **empty($seq)** :
> Returns true if the sequence has no items.
```
empty(()) → true
```
