# Insertion, filtres et suppression

## 1. Insérer des documents
Concepts clés :  
 - insertOne() ajoute un document ;
 - insertMany() ajoute plusieurs documents en une seule opération. MongoDB génère automatiquement _id si vous ne le fournissez pas.

Exemples mongosh
```js
use demoDB
db.etudiants.insertOne({ nom: "Roger", age: 51, interets: ["sport", "cuisine"] })
db.etudiants.insertMany([
  { nom: "Bob", age: 22, interets: ["sport", "cinéma"] },
  { nom: "Claire", age: 24, interets: ["lecture", "dessin"] },
  { nom: "David", age: 27, interets: ["voyage", "programmation"] },
  { nom: "Emma", age: 21, interets: ["danse", "musique"] },
  { nom: "Farid", age: 23, interets: ["football", "cuisine"] },
  { nom: "Giulia", age: 26, interets: ["mode", "voyage"] },
  { nom: "Hugo", age: 20, interets: ["gaming", "musique"] },
  { nom: "Isabelle", age: 28, interets: ["yoga", "lecture"] },
  { nom: "Jonas", age: 22, interets: ["programmation", "voyage"] },
  { nom: "Khadija", age: 25, interets: ["cuisine", "cinéma"] },
  { nom: "Louis", age: 23, interets: ["sport", "voyage"] },
  { nom: "Maria", age: 24, interets: ["musique", "peinture"] },
  { nom: "Nicolas", age: 27, interets: ["lecture", "randonnée"] },
  { nom: "Olivia", age: 22, interets: ["danse", "mode"] },
  { nom: "Pierre", age: 26, interets: ["programmation", "gaming"] },
  { nom: "Quentin", age: 21, interets: ["voyage", "musique"] },
  { nom: "Rania", age: 23, interets: ["lecture", "cuisine"] },
  { nom: "Sophie", age: 25, interets: ["cinéma", "voyage"] },
  { nom: "Thomas", age: 24, interets: ["sport", "musique"] }
])
```
Vérification : la commande retourne `acknowledged: true` et `insertedId(s)` pour confirmer l’insertion.

## 2. Requêter et sélectionner
find() est la méthode de base pour lire des documents. Vous pouvez combiner filtre, projection, tri, pagination.

Syntaxe de base
js
db.books.find({ author: "Orwell" })                // filtre
db.books.find({}, { title: 1, year: 1, _id: 0 })   // projection
db.books.find().sort({ year: -1 })                 // tri décroissant
db.books.find().skip(10).limit(5)                  // pagination
Important : les filtres utilisent la même syntaxe que pour les suppressions et peuvent inclure opérateurs ($gt, $lt, $in, $regex, etc.). Pour trier, 1 = croissant, -1 = décroissant.

3. Filtrer avancé
Comparaisons : { year: { $gte: 2000 } }

Combinaisons : { $and: [ { a: 1 }, { b: 2 } ] } ou { $or: [...] }

Recherche textuelle : index textuel + { $text: { $search: "mot" } } Astuce : indexez les champs fréquemment filtrés pour accélérer les requêtes.

4. Supprimer des documents
Méthodes : deleteOne(filter) supprime au plus un document ; deleteMany(filter) supprime tous les documents correspondant au filtre ; deleteMany({}) supprime toute la collection (attention).

Exemples
js
db.books.deleteOne({ title: "1984" })
db.books.deleteMany({ year: { $lt: 1900 } })
db.books.deleteMany({})   // supprime tous les documents
Retour : MongoDB renvoie un document de statut indiquant le nombre supprimé et si l’opération a été reconnue.

Risques, limitations et bonnes pratiques
Risque de suppression accidentelle : évitez deleteMany({}) en production ; testez d’abord avec find() pour vérifier le filtre.

Performance : sans index, les filtres et tris peuvent provoquer des scans complets ; créez des index adaptés au modèle d’accès.

Atomicité : insertMany n’est pas atomique par défaut ; en cas d’erreur partielle, certains documents peuvent être insérés — utilisez transactions si nécessaire.

Insérer plusieurs étudiants:
```javascript
db.etudiants.insertMany([
  { nom: "Bob", age: 22, interets: ["sport", "cinéma"] },
  { nom: "Claire", age: 24, interets: ["lecture", "dessin"] },
  { nom: "David", age: 27, interets: ["voyage", "programmation"] },
  { nom: "Emma", age: 21, interets: ["danse", "musique"] },
  { nom: "Farid", age: 23, interets: ["football", "cuisine"] },
  { nom: "Giulia", age: 26, interets: ["mode", "voyage"] },
  { nom: "Hugo", age: 20, interets: ["gaming", "musique"] },
  { nom: "Isabelle", age: 28, interets: ["yoga", "lecture"] },
  { nom: "Jonas", age: 22, interets: ["programmation", "voyage"] },
  { nom: "Khadija", age: 25, interets: ["cuisine", "cinéma"] },
  { nom: "Louis", age: 23, interets: ["sport", "voyage"] },
  { nom: "Maria", age: 24, interets: ["musique", "peinture"] },
  { nom: "Nicolas", age: 27, interets: ["lecture", "randonnée"] },
  { nom: "Olivia", age: 22, interets: ["danse", "mode"] },
  { nom: "Pierre", age: 26, interets: ["programmation", "gaming"] },
  { nom: "Quentin", age: 21, interets: ["voyage", "musique"] },
  { nom: "Rania", age: 23, interets: ["lecture", "cuisine"] },
  { nom: "Sophie", age: 25, interets: ["cinéma", "voyage"] },
  { nom: "Thomas", age: 24, interets: ["sport", "musique"] }
])
```
