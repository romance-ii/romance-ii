/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.geometry;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * A mesh of triangles, sharing some vertices
 * 
 * @author brpocock@star-hope.org
 */
public class TriangleMesh {
	/**
	 * Edges
	 */
	private final Set <LineSeg3D> edges = new HashSet <LineSeg3D> ();
	/**
	 * Triangles
	 */
	private final Set <Triangle> triangles = new HashSet <Triangle> ();
	/**
	 * Vertices
	 */
	private final Set <Coord3D> vertices = new HashSet <Coord3D> ();

	/**
	 * Add a triangle to the mesh
	 * 
	 * @param t the new triangle
	 */
	public synchronized void add (final Triangle t) {
		triangles.add (t);
		edges.addAll (t.getEdges ());
		vertices.addAll (t.getVertices ());
	}

	/**
	 * Clean up vertices or edges that are no longer required by any
	 * triangles in the mesh.
	 */
	public synchronized void cleanup () {
		EDGES: for (final LineSeg3D edge : edges) {
			for (final Triangle t : triangles) {
				if (t.hasEdge (edge)) {
					break EDGES;
				}
			}
			edges.remove (edge);
		}
	VERTICES: for (final Coord3D vertex : vertices) {
		for (final Triangle t : triangles) {
			if (t.hasVertex (vertex)) {
				break VERTICES;
			}
		}
		vertices.remove (vertex);
	}
	}

	/**
	 * Clear all contents
	 */
	public void clear () {
		vertices.clear ();
		triangles.clear ();
		edges.clear ();
	}

	/**
	 * Get any triangles adjacent to the given one (sharing edges)
	 * 
	 * @param t a triangle
	 * @return any triangles in this mesh which share an edge with it
	 *         (precisely)
	 */
	public Collection <Triangle> getAdjacentTriangles (final Triangle t) {
		final Set <Triangle> hits = new HashSet <Triangle> ();
		final Collection <LineSeg3D> hisEdges = t.getEdges ();
		TRIANGLES: for (final Triangle x : triangles) {
			for (final LineSeg3D edge : hisEdges) {
				if (x.hasEdge (edge)) {
					hits.add (x);
					continue TRIANGLES;
				}
			}
		}
		return hits;
	}

	/**
	 * <p>
	 * Subtract a triangle from the mesh.
	 * </p>
	 * <p>
	 * Note that triangles are considered to be perfectly zero-depth, so
	 * non-coplanar triangles have no effect upon one another.
	 * </p>
	 * <p>
	 * If the triangle is a simple member of the mesh, it will just be
	 * removed.
	 * </p>
	 * <p>
	 * If the triangle is coplanar and coïncident upon any triangle(s)
	 * in the mesh, they will be divided to remove the area of the
	 * subtracted triangle.
	 * </p>
	 * 
	 * @param t the triangle to be removed
	 */
	public synchronized void subtract (final Triangle t) {

		/*
		 * Simplest case: nothing to do; “t” is null, or not really a
		 * triangle (non-plane-defining)
		 */
		if (null == t) return;
		if (t.isNotPlane()) return;

		/*
		 * Simple case: Single triangle removed from mesh directly.
		 */
		if (triangles.contains (t)) {
			triangles.remove (t);
			cleanup ();
			return;
		}

		/*
		 * Find any triangles which intersect this one.
		 */
		for (final Triangle tri : triangles) {
			if (tri.intersects (t)) {
				triangles.addAll (tri.subtract (t));
				triangles.remove (tri);
				cleanup ();
			}
		}

	}
}
