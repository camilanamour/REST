package br.edu.fateczl.ExemploREST.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.ExemploREST.model.entity.Avaliacao;

public interface AvaliacaoRepository extends JpaRepository<Avaliacao, Integer> {
	
	public Avaliacao findByCode(Integer codigo);

}
