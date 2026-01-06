using MAP___Laborator_10.domain;

namespace MAP___Laborator_10.repository;

//generic repository
internal interface Repository<ID, E> where E : Entity<ID>
{
    E FindOne(ID id);
    IEnumerable<E> FindAll();
    E Save(E entity);
    E Delete(ID id);
    E Update(E entity);
}
