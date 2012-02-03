package org.starhope.appius.physica;
/*
 * The Triangulator - a java applet which animates some brute force
 * Delaunay triangulation algorithms of varying computational
 * complexity. Author: Geoff Leach. gl@cs.rmit.edu.au Date: 29/3/96
 * License to copy and use this software is granted provided that
 * appropriate credit is given to both RMIT and the author. The point of
 * the applet is educational: (a) To illustrate the importance of
 * computational complexity. The three Delaunay triangulation algorithms
 * implemented have computational complexities of O(n^2), O(n^3) and
 * O(n^4). The user can see for themselves the improvement in speed
 * going from O(n^4) to O(n^2). (b) To illustrate what Delaunay
 * triangulations are. The Delaunay triangulation, and the related
 * Voronoi diagram, is a particularly useful data structure for a number
 * of problems. Without going into the applications the applet attempts
 * to show what Delaunay triangulation algorithms are. (c) To provide a
 * useful context for me to initially learn Java. The code still needs
 * polishing ...
 */

import java.awt.geom.Point2D;
import java.io.PrintStream;

import org.starhope.appius.game.AppiusClaudiusCaecus;


///*
// * Point class.  RealPoint to avoid clash with java.awt.Point.
// */
//class RealPoint {
//    double x, y;
//
//    RealPoint() { x = y = 0.0f; }
//    RealPoint(double x, double y) { this.x = x; this.y = y; }
//    RealPoint(RealPoint p) { x = p.x; y = p.y; }
//    public double x() { return this.x; }
//    public double y() { return this.y; }
//    public void set(double x, double y) { this.x = x; this.y = y; }
//
//    public double distance(RealPoint p) {
//	double dx, dy;
//
//	dx = p.x - x;
//	dy = p.y - y;
//	return (float)Math.sqrt((double)(dx * dx + dy * dy));
//    }
//
//    public double distanceSq(RealPoint p) {
//	double dx, dy;
//
//	dx = p.x - x;
//	dy = p.y - y;
//	return (float)(dx * dx + dy * dy);
//    }
//}


/**
 * Circle class. Circles are fundamental to computation of Delaunay
 * triangulations.  In particular, an operation which computes a
 * circle defined by three points is required.
 */
class Circle {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Point2D.Double centre;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	double radius;

	/**
	 * WRITEME
	 */
	Circle () {
		centre = new Point2D.Double ();
		radius = 0.0f;
	}

	/**
	 * @param newCentre WRITEME
	 * @param newRadius WRITEME
	 */
	Circle (final Point2D.Double newCentre, final double newRadius) {
		centre = newCentre;
		radius = newRadius;
	}

	/**
	 * Tests if a point lies inside the circle instance.
	 * 
	 * @param p WRITEME
	 * @return WRITEME
	 */
	public boolean contains (final Point2D.Double p) {
		if (centre.distanceSq (p) < radius * radius) return true;
		return false;
	}

	/**
	 * Compute the circle defined by three points (circumcircle).
	 * 
	 * @param p1 WRITEME
	 * @param p2 WRITEME
	 * @param p3 WRITEME
	 */
	public void findCircumcircle (final Point2D.Double p1,
			final Point2D.Double p2, final Point2D.Double p3)
	{
		double cp;

		cp = LeachVector.crossProduct(p1, p2, p3);
		if (cp != 0.0)
		{
			double p1Sq, p2Sq, p3Sq;
			double num;
			// final double den;
			double cx, cy;

			p1Sq = p1.getX() * p1.getX() + p1.getY() * p1.getY();
			p2Sq = p2.getX() * p2.getX() + p2.getY() * p2.getY();
			p3Sq = p3.getX() * p3.getX() + p3.getY() * p3.getY();
			num = p1Sq*(p2.getY() - p3.getY()) + p2Sq*(p3.getY() - p1.getY()) + p3Sq*(p1.getY() - p2.getY());
			cx = num / (2.0f * cp);
			num = p1Sq*(p3.getX() - p2.getX()) + p2Sq*(p1.getX() - p3.getX()) + p3Sq*(p2.getX() - p1.getX());
			cy = num / (2.0f * cp);

			centre = new Point2D.Double (cx, cy);
		}

		// Radius
		radius = centre.distance (p1);
	}

	/**
	 * @return WRITEME
	 */
	public Point2D.Double getCentre() { return centre; }

	/**
	 * @return radius
	 */
	public double getRadius () {
		return radius;
	}

	/**
	 * @param c WRITEME
	 * @param r WRITEME
	 */
	public void set (final Point2D.Double c, final double r) {
		centre = c;
		radius = r;
	}
}

/**
 * CubicAlgorithm class. O(n^3) algorithm.
 */
class CubicAlgorithm extends TriangulationAlgorithm {

	/**
	 * WRITEME
	 */
	final static String cubicAlgName = "O(n^3)";
	/**
	 * WRITEME
	 */
	Circle bC = new Circle();
	/**
	 * WRITEME
	 */
	int i;
	/**
	 * WRITEME
	 */
	int nFaces;
	/**
	 * WRITEME
	 */
	int s;
	/**
	 * WRITEME
	 */
	int t;
	/**
	 * WRITEME
	 */
	int u;

	/**
	 * @param tri WRITEME
	 * @param nPoints WRITEME
	 */
	public CubicAlgorithm (final Triangulation tri, final int nPoints) {
		super (tri, CubicAlgorithm.cubicAlgName, nPoints);
	}

	/**
	 * Add new triangle or update edge info if s-t is on hull.
	 * 
	 * @param eI WRITEME
	 * @param tri WRITEME
	 * @param numFaces WRITEME
	 */
	private void addOrUpdateTriangle (final int eI, final Triangulation tri,
			final int numFaces) {
		int eIo=eI;
		int faces = numFaces;

		if (u < tri.nPoints) {
			final int bP = u;

			// Update face information of edge being completed.
			tri.updateLeftFace(eI, s, t, faces);
			faces++;

			// Add new edge or update face info of old edge.
			eIo = tri.findEdge(bP, s);
			if (eIo == Triangulation.Undefined) {
				// New edge.
				eIo = tri.addEdge(bP, s, faces, Triangulation.Undefined);
			} else {
				// Old edge.
				tri.updateLeftFace(eIo, bP, s, faces);
			}

			// Add new edge or update face info of old edge.
			eIo = tri.findEdge(t, bP);
			if (eIo == Triangulation.Undefined) {
				// New edge.
				eIo = tri.addEdge(t, bP, faces, Triangulation.Undefined);
			} else {
				// Old edge.
				tri.updateLeftFace(eIo, t, bP, faces);
			}
		} else {
			tri.updateLeftFace(eIo, s, t, Triangulation.Universe);
		}
	}

	/**
	 * Complete a facet by looking for the circle free point to the left
	 * of the edge "e_i". Add the facet to the triangulation. This
	 * function is a bit long and may be better split.
	 *
	 * @param eI WRITEME
	 * @param tri WRITEME
	 * @param numFaces WRITEME
	 */
	public void completeFacet(final int eI, final Triangulation tri, final int numFaces) {
		final int faces = numFaces;
		final Edge e[] = tri.edge;
		final Point2D.Double p[] = tri.point;

		// Cache s and t.
		if (e[eI].l0 == Triangulation.Undefined)
		{
			s = e[eI].s0;
			t = e[eI].t0;
		}
		else if (e[eI].r0 == Triangulation.Undefined)
		{
			s = e[eI].t0;
			t = e[eI].s0;
		} else // Edge already completed.
			return;

		findPointFreeCircumcircle (tri, p);

		addOrUpdateTriangle (eI, tri, faces);
	}

	/**
	 *  Find the two closest points.
	 * @param p WRITEME
	 * @param nPoints WRITEME
	 * @return WRITEME
	 */
	public Point2D findClosestNeighbours(final Point2D.Double p[], final int nPoints) {
		int i0, j0;
		double d, min;
		int s0 = 0, t0 = 0;

		min = Double.MAX_VALUE;
		for (i0 = 0; i0 < nPoints-1; i0++) {
			for (j0 = i0+1; j0 < nPoints; j0++)
			{
				d = p[i0].distanceSq(p[j0]);
				if (d < min)
				{
					s0 = i0;
					t0 = j0;
					min = d;
				}
			}
		}
		return new Point2D.Double (s0,t0);
	}


	/**
	 *  Find point free circumcircle to the left.
	 * @param tri WRITEME
	 * @param p WRITEME
	 */
	private void findPointFreeCircumcircle (final Triangulation tri,
			final Point2D.Double[] p) {
		double cP;
		boolean pointFree;

		for (u = 0; u < tri.nPoints; u++) {
			if (u != s && u != t) {
				if (LeachVector.crossProduct(p[s], p[t], p[u]) > 0.0) {
					bC.findCircumcircle (p [s], p [t], p [u]);
					pointFree = true;
					for (i = 0; i < tri.nPoints; i++) {
						if (i != s && i != t && i != u) {
							cP = LeachVector.crossProduct(p[s], p[t], p[i]);
							if (cP > 0.0) {
								if (bC.contains (p [i])) {
									pointFree = false;
									break;
								}
							}
						}
					}
					if (pointFree) {
						break;
					}
				}
			}
		}
	}

	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#reset()
	 */
	@Override
	public void reset() {
		nFaces = 0;
		super.reset();
	}

	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#triangulate(org.starhope.appius.physica.Triangulation)
	 */
	@Override
	public synchronized void triangulate(final Triangulation tri) {
		int currentEdge;
		final int numFaces = 0;
		final int s0, t0;


		// Find closest neighbours and add edge to triangulation.
		final Point2D next =  findClosestNeighbours(tri.point, tri.nPoints);
		s0 = (int) next.getX ();
		t0 = (int) next.getY ();

		// Create seed edge and add it to the triangulation.
		/* int seedEdge = */tri.addEdge (s0, t0,
				Triangulation.Undefined,
				Triangulation.Undefined);

		currentEdge = 0;
		while (currentEdge < tri.nEdges)
		{
			if (tri.edge [currentEdge].l0 == Triangulation.Undefined) {
				completeFacet (currentEdge, tri, numFaces);
			}
			if (tri.edge [currentEdge].r0 == Triangulation.Undefined) {
				completeFacet (currentEdge, tri, numFaces);
			}
			currentEdge++;
		}
	}
}

/**
 * Edge class. Edges have two vertices, s and t, and two faces,
 * l (left) and r (right). The triangulation representation and
 * the Delaunay triangulation algorithms require edges.
 */
class Edge {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int l0;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int r0;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int s0;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int t0;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	Edge () {
		s0 = t0 = 0;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param s WRITEME
	 * @param t WRITEME
	 */
	Edge (final int s, final int t) {
		s0 = s;
		t0 = t;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	int getL () {
		return l0;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	int getR () {
		return r0;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	int getS () {
		return s0;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	int getT () {
		return t0;
	}
}

/**
 * Vector class.  A few elementary vector operations.
 */
class LeachVector {
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p1 WRITEME
	 * @param p2 WRITEME
	 * @param p3 WRITEME
	 * @return WRITEME
	 */
	static double crossProduct(final Point2D.Double p1, final Point2D.Double p2, final Point2D.Double p3) {
		double u1, v1, u2, v2;

		u1 =  p2.getX() - p1.getX();
		v1 =  p2.getY() - p1.getY();
		u2 =  p3.getX() - p1.getX();
		v2 =  p3.getY() - p1.getY();

		return u1 * v2 - v1 * u2;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p1 WRITEME
	 * @param p2 WRITEME
	 * @param p3 WRITEME
	 * @return WRITEME
	 */
	static double dotProduct(final Point2D.Double p1, final Point2D.Double p2, final Point2D.Double p3) {
		double u1, v1, u2, v2;

		u1 =  p2.getX () - p1.getX();
		v1 =  p2.getY() - p1.getY();
		u2 =  p3.getX () - p1.getX();
		v2 =  p3.getY() - p1.getY();

		return u1 * u2 + v1 * v2;
	}

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	double u;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	double v;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	LeachVector() { u = v = 0.0f; }

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newU WRITEME
	 * @param newV WRITEME
	 */
	LeachVector (final double newU, final double newV) {
		u = newU;
		v = newV;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param p1 WRITEME
	 * @param p2 WRITEME
	 */
	LeachVector(final Point2D.Double p1, final Point2D.Double p2) {
		u = p2.getX() - p1.getX();
		v = p2.getY() - p1.getY();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newV WRITEME
	 * @return WRITEME
	 */
	double crossProduct (final LeachVector newV) {
		return u * newV.v - v * newV.u;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newV WRITEME
	 * @return WRITEME
	 */
	double dotProduct (final LeachVector newV) {
		return u * newV.u + v * newV.v;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p1 WRITEME
	 * @param p2 WRITEME
	 */
	void setPoints(final Point2D.Double p1, final Point2D.Double p2) {
		u = p2.getX() - p1.getX();
		v = p2.getY() - p1.getY();
	}
}

/**
 * QuadraticAlgorithm class. O(n^2) algorithm.
 */
class QuadraticAlgorithm extends TriangulationAlgorithm {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final static String algoName = "O(n^2)";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Circle bC = new Circle();
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int bP;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int nFaces;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int s;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int t;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int u;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param t1 WRITEME
	 * @param nPoints WRITEME
	 */
	public QuadraticAlgorithm (final Triangulation t1, final int nPoints) {
		super (t1, QuadraticAlgorithm.algoName, nPoints);
	}

	/**
	 * Complete a facet by looking for the circle free point to the left
	 * of the edge "e_i". Add the facet to the triangulation. This
	 * function is a bit long and may be better split.
	 * 
	 * @param eIeI2 WRITEME
	 * @param tri0 WRITEME
	 * @param numberOfFaces WRITEME
	 */
	public void completeFacet (final int eIeI2,
			final Triangulation tri0,
			final int numberOfFaces) {
		int numFaces = numberOfFaces;
		final Edge e[] = tri0.edge;
		final Point2D.Double p[] = tri0.point;

		int eI2 = eIeI2;
		if (e [eI2].l0 == Triangulation.Undefined) {
			s = e [eI2].s0;
			t = e [eI2].t0;
		} else if (e [eI2].r0 == Triangulation.Undefined) {
			s = e [eI2].t0;
			t = e [eI2].s0;
		} else // Edge already completed.
			return;

		// Find a point on left of edge.
		for (u = 0; u < tri0.nPoints; u++ )
		{
			if (u == s || u == t) {
				continue;
			}
			if (LeachVector.crossProduct(p[s], p[t], p[u]) > 0.0) {
				break;
			}
		}

		findBestPointOnLeftOfEdge (tri0, p);

		// Add new triangle or update edge info if s-t is on hull.
		if (bP < tri0.nPoints)
		{
			// Update face information of edge being completed.
			tri0.updateLeftFace (eI2, s, t, numFaces);
			numFaces++ ;

			// Add new edge or update face info of old edge.
			eI2 = tri0.findEdge (bP, s);
			if (eI2 == Triangulation.Undefined) {
				// New edge.
				eI2 = tri0.addEdge (bP, s, numFaces,
						Triangulation.Undefined);
			} else {
				// Old edge.
				tri0.updateLeftFace (eI2, bP, s, numFaces);
			}

			// Add new edge or update face info of old edge.
			eI2 = tri0.findEdge (t, bP);
			if (eI2 == Triangulation.Undefined) {
				// New edge.
				eI2 = tri0.addEdge (t, bP, numFaces,
						Triangulation.Undefined);
			} else {
				// Old edge.
				tri0.updateLeftFace (eI2, t, bP, numFaces);
			}
		} else {
			tri0.updateLeftFace (eI2, s, t, Triangulation.Universe);
		}
	}

	/**
	 * Find best point on left of edge.
	 * 
	 * @param tri0 WRITEME
	 * @param p WRITEME
	 */
	private void findBestPointOnLeftOfEdge (final Triangulation tri0,
			final Point2D.Double[] p) {
		double cP;
		bP = u;
		if (bP < tri0.nPoints) {
			bC.findCircumcircle (p [s], p [t], p [bP]);
			for (u = bP + 1; u < tri0.nPoints; u++ ) {
				if (u == s || u == t) {
					continue;
				}
				cP = LeachVector.crossProduct (p [s], p [t], p [u]);
				if (cP > 0.0) {
					if (bC.contains (p [u])) {
						bP = u;
						bC.findCircumcircle (p [s], p [t], p [u]);
					}
				}
			}
		}
	}

	/**
	 * Find the two closest points.
	 * 
	 * @param p WRITEME
	 * @param nPoints WRITEME
	 * @return WRITEME
	 */
	public Point2D findClosestNeighbours (final Point2D.Double p[],
			final int nPoints
	) {
		int i, j;
		double d, min;
		int s0, t0;

		s0 = t0 = 0;
		min = Float.MAX_VALUE;
		for (i = 0; i < nPoints-1; i++) {
			for (j = i+1; j < nPoints; j++)
			{
				d = p[i].distanceSq(p[j]);
				if (d < min)
				{
					s0 = i;
					t0 = j;
					min = d;
				}
			}
		}
		return new Point2D.Double (s0, t0);
	}

	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#reset()
	 */
	@Override
	public void reset() {
		nFaces = 0;

		super.reset();
	}

	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#triangulate(org.starhope.appius.physica.Triangulation)
	 */
	@Override
	public synchronized void triangulate(final Triangulation tri) {
		int currentEdge;
		int numFaces;
		int s1, t1;

		// Initialise.
		numFaces = 0;



		// Find closest neighbours and add edge to triangulation.
		final Point2D p =findClosestNeighbours(tri.point, tri.nPoints);
		s1 = (int) p.getX ();
		t1 = (int) p.getY ();

		// Create seed edge and add it to the triangulation.
		/* seedEdge = */tri.addEdge (s1, t1,
				Triangulation.Undefined,
				Triangulation.Undefined);

		currentEdge = 0;
		while (currentEdge < tri.nEdges) {
			if (tri.edge [currentEdge].l0 == Triangulation.Undefined) {
				completeFacet (currentEdge, tri, numFaces);

			}
			if (tri.edge [currentEdge].r0 == Triangulation.Undefined) {
				completeFacet (currentEdge, tri, numFaces);

			}
			currentEdge++;
		}
	}
}

/**
 * QuarticAlgorithm class. O(n^4) algorithm. The most brute-force of the
 * algorithms.
 */
class QuarticAlgorithm extends TriangulationAlgorithm {
	/**
	 *
	 */
	final static String algoName = "O(n^4)";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Circle c = new Circle();
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int i;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int j;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int k;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int l;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param t WRITEME
	 * @param nPoints WRITEME
	 */
	public QuarticAlgorithm(final Triangulation t,  final int nPoints) {
		super (t, QuarticAlgorithm.algoName, nPoints);
	}


	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#reset()
	 */
	@Override
	public void reset() {
		i = j = k = l = 0;
		super.reset();
	}

	/**
	 * @see org.starhope.appius.physica.TriangulationAlgorithm#triangulate(org.starhope.appius.physica.Triangulation)
	 */
	@Override
	public synchronized void triangulate(final Triangulation t) {
		boolean pointFree;
		final int n = t.nPoints;
		final Point2D.Double p[] = t.point;

		for (i = 0; i < n-2; i++) {
			for (j = i + 1; j < n-1; j++) {
				if (j != i) {
					for (k = j + 1; k < n; k++) {
						if (k != i && k != j)
						{
							c.findCircumcircle (p [i], p [j], p [k]);

							pointFree = true;
							for (l = 0; l < n; l++) {
								if (l != i && l != j && l != k) {

									if (c.contains (p [l])) {

										pointFree = false;
										break;
									}
								}
							}

							if (pointFree) {
								t.addTriangle(i, j, k);
							}


						}
					}
				}
			}
		}
	}
}

/**
 * Rectangle class. Need rectangles for window to viewport mapping.
 */
class RealRectangle {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Point2D.Double ll;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Point2D.Double ur;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	RealRectangle () {
		// no op, leave members uninitialised
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param xMin WRITEME
	 * @param yMin WRITEME
	 * @param xMax WRITEME
	 * @param yMax WRITEME
	 */
	RealRectangle(final double xMin, final double yMin, final double xMax, final double yMax) {
		ll = new Point2D.Double(xMin, yMin);
		ur = new Point2D.Double(xMax, yMax);
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param lowerLeft WRITEME
	 * @param upperRight WRITEME
	 */
	RealRectangle (final Point2D.Double lowerLeft,
			final Point2D.Double upperRight) {
		ll = new Point2D.Double (lowerLeft.getX (), lowerLeft.getY ());
		ur = new Point2D.Double (upperRight.getX (), upperRight.getY ());
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param r WRITEME
	 */
	RealRectangle (final RealRectangle r) {
		ll = new Point2D.Double(r.ll.getX (), r.ll.getY());
		ur = new Point2D.Double(r.ur.getX(), r.ur.getY ());
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double height() { return ur.getY() - ll.getY(); }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Point2D.Double ll() { return ll; }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Point2D.Double ur() { return ur; }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double width() { return ur.getX() - ll.getX(); }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double xMax() { return ur.x; }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double xMin() { return ll.x; }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double yMax() { return ur.y; }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double yMin() { return ll.y; }
}

/**
 * Triangulation class.  A triangulation is represented as a set of
 * points and the edges which form the triangulation.
 */
class Triangulation {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int Undefined = -1;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int Universe = 0;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Edge edge[];
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int maxEdges;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int nEdges;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	int nPoints;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Point2D.Double point[];

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param numPoints WRITEME
	 */
	Triangulation (final int numPoints) {

		// Allocate points.
		nPoints = numPoints;
		point = new Point2D.Double [numPoints];
		for (int i = 0; i < numPoints; i++ ) {
			point[i] = new Point2D.Double();
		}

		// Allocate edges.
		maxEdges = 3 * numPoints - 6; // Max number of edges.
		edge = new Edge[maxEdges];
		for (int i = 0; i < maxEdges; i++) {
			edge[i] = new Edge();
		}
		nEdges = 0;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param s WRITEME
	 * @param t WRITEME
	 * @return WRITEME
	 */
	public int addEdge(final int s, final int t) {
		return addEdge(s, t, Triangulation.Undefined, Triangulation.Undefined);
	}

	/**
	 * Adds an edge to the triangulation. Store edges with lowest vertex
	 * first (easier to debug and makes no other difference).
	 * 
	 * @param s WRITEME
	 * @param t WRITEME
	 * @param l WRITEME
	 * @param r WRITEME
	 * @return WRITEME
	 */
	public int addEdge(final int s, final int t, final int l, final int r) {
		int e;

		// Add edge if not already in the triangulation.
		e = findEdge(s, t);
		if (e == Triangulation.Undefined) {
			if (s < t)
			{
				edge [nEdges].s0 = s;
				edge [nEdges].t0 = t;
				edge [nEdges].l0 = l;
				edge [nEdges].r0 = r;
				return nEdges++;
			}
			edge [nEdges].s0 = t;
			edge [nEdges].t0 = s;
			edge [nEdges].l0 = r;
			edge [nEdges].r0 = l;
			return nEdges++ ;
		}
		return Triangulation.Undefined;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param s WRITEME
	 * @param t WRITEME
	 * @param u WRITEME
	 */
	void addTriangle(final int s, final int t, final int u) {
		addEdge(s, t);
		addEdge(t, u);
		addEdge(u, s);
	}

	/**
	 * Copies a set of points.
	 * 
	 * @param t WRITEME
	 */
	public void copyPoints(final Triangulation t) {
		int n;

		if (t.nPoints < nPoints) {
			n = t.nPoints;
		} else {
			n = nPoints;
		}

		for (int i = 0; i < n; i++) {
			point[i].x = t.point[i].x;
			point[i].y = t.point[i].y;
		}

		nEdges = 0;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param s WRITEME
	 * @param t WRITEME
	 * @return WRITEME
	 */
	public int findEdge(final int s, final int t) {
		boolean edgeExists = false;
		int i;

		for (i = 0; i < nEdges; i++) {
			if (edge [i].s0 == s && edge [i].t0 == t
					|| edge [i].s0 == t && edge [i].t0 == s) {
				edgeExists = true;
				break;
			}
		}

		if (edgeExists) return i;
		return Triangulation.Undefined;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p WRITEME
	 */
	public void print(final PrintStream p) {
		printPoints(p);
		printEdges(p);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p WRITEME
	 */
	public void printEdges(final PrintStream p) {
		for (int i = 0; i < nEdges; i++) {
			p.println (String.valueOf (edge [i].s0) + " "
					+ String.valueOf (edge [i].t0));
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param p WRITEME
	 */
	public void printPoints(final PrintStream p) {
		for (int i = 0; i < nPoints; i++) {
			p.println(String.valueOf(point[i].x) + " " + String.valueOf(point[i].y));
		}
	}

	/**
	 * Sets the number of points in the triangulation. Reuses already
	 * allocated points and edges.
	 * 
	 * @param numPoints WRITEME
	 */
	public void setNPoints (final int numPoints) {
		// Fix edge array.
		final Edge tmpEdge[] = edge;
		final int tmpMaxEdges = maxEdges;
		maxEdges = 3 * numPoints - 6; // Max number of edges.
		edge = new Edge[maxEdges];

		// Which is smaller?
		int minMaxEdges;
		if (tmpMaxEdges < maxEdges) {
			minMaxEdges = tmpMaxEdges;
		} else {
			minMaxEdges = maxEdges;
		}

		// Reuse allocated edges.
		for (int i = 0; i < minMaxEdges; i++) {
			edge[i] = tmpEdge[i];
		}

		// Get new edges.
		for (int i = minMaxEdges; i < maxEdges; i++) {
			edge[i] = new Edge();
		}

		// Fix point array.
		final Point2D.Double tmpPoint[] = point;
		point = new Point2D.Double [numPoints];

		// Which is smaller?
		int minPoints;
		if (numPoints < nPoints) {
			minPoints = numPoints;
		} else {
			minPoints = nPoints;
		}

		// Reuse allocated points.
		for (int i = 0; i < minPoints; i++) {
			point[i] = tmpPoint[i];
		}

		// Get new points.
		for (int i = minPoints; i < numPoints; i++ ) {
			point[i] = new Point2D.Double();
		}

		nPoints = numPoints;
	}

	/**
	 * Update the left face of an edge.
	 * 
	 * @param eI WRITEME
	 * @param s WRITEME
	 * @param t WRITEME
	 * @param f WRITEME
	 */
	public void updateLeftFace(final int eI, final int s, final int t, final int f) {
		if ( ! (edge [eI].s0 == s && edge [eI].t0 == t || edge [eI].s0 == t
				&& edge [eI].t0 == s)) {
			AppiusClaudiusCaecus.fatalBug ("updateLeftFace: adj. matrix and edge table mismatch");
		}
		if (edge [eI].s0 == s
				&& edge [eI].l0 == Triangulation.Undefined) {
			edge [eI].l0 = f;
		} else if (edge [eI].t0 == s
				&& edge [eI].r0 == Triangulation.Undefined) {
			edge [eI].r0 = f;
		} else {
			AppiusClaudiusCaecus.fatalBug("updateLeftFace: attempt to overwrite edge info");
		}
	}
}

/**
 * TriangulationAlgorithm class. Absract. Superclass for actual
 * algorithms. Has several abstract function members - including the
 * triangulation member which actually computes the triangulation.
 */
abstract class TriangulationAlgorithm {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int edgeState = 5;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int insideState = 4;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int pointState = 1;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int triangleState = 2;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	static final int triangulationState = 0;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final String algName;
	// Variables and constants for animation state.
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final int nStates = 5;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	boolean state[] = new boolean[nStates];

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param t WRITEME
	 * @param name WRITEME
	 * @param nPoints WRITEME
	 */
	public TriangulationAlgorithm (final Triangulation t,
			final String name, final int nPoints) {
		algName = name;

		for (int s = 0; s < nStates; s++) {
			state[s] = false;
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public synchronized void nextStep() { notify(); }


	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void reset() {
		for (int s = 0; s < nStates; s++) {
			state[s] = false;
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param stateVar WRITEME
	 * @param value WRITEME
	 */
	public void setAlgorithmState(final int stateVar, final boolean value) {
		state[stateVar] = value;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param t WRITEME
	 */
	abstract public void triangulate (Triangulation t);
}

