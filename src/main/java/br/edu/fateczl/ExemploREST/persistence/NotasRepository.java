package br.edu.fateczl.ExemploREST.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import br.edu.fateczl.ExemploREST.model.entity.Disciplina;
import br.edu.fateczl.ExemploREST.model.entity.Notas;

public interface NotasRepository extends JpaRepository<Notas, Integer>{
	
	List<Notas> findAllByDisciplina(Disciplina disciplina);
    @Transactional
    @Modifying
    @Query(value = "INSERT INTO notas(ra_aluno,codigo_disciplina,codigo_avaliacao,nota) VALUES(?1,?2,?3,?4)", nativeQuery = true)
    void saveNotas(String ra, String codigo, int codAvaliacao, Double nota);
    @Transactional
    @Modifying
    @Query(value = "UPDATE notas SET nota = ?4 WHERE ra_aluno=?1 AND codigo_disciplina=?2 AND codigo_avaliacao=?3", nativeQuery = true)
    void updateNotas(String ra, String codigo, int codAvaliacao, Double nota);

}
