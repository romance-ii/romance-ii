/**
 * <p>
 * Copyright © 2010-2012 Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.geometry;

import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.game.BugReporter;

/**
 * A triangle
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Triangle {
	/**
	 * The mathematical definition of “close enough”
	 */
	private static double epsilon = 0.0001;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static boolean useEpsilonTest;
	/**
	 * Vertices
	 */
	private final Coord3D points[];
	
	/**
	 * Create a planar triangle with the given vertices
	 * 
	 * @param newPoints the vertices
	 */
	public Triangle (final Coord2D newPoints[]) {
		assert newPoints.length == 3 : "Triangles have three sides";
		points = new Coord3D [3];
		points [0] = newPoints [0].toCoord3D ();
		points [1] = newPoints [1].toCoord3D ();
		points [2] = newPoints [2].toCoord3D ();
	}
	
	/**
	 * Create a triangle with the given vertices
	 * 
	 * @param newPoints vertices
	 */
	public Triangle (final Coord3D newPoints[]) {
		assert newPoints.length == 3 : "Triangles have three sides.";
		points = Arrays.copyOf (newPoints, 3);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param VV0 WRITEME: Document this method brpocock@star-hope.org
	 * @param VV1 WRITEME: Document this method brpocock@star-hope.org
	 * @param VV2 WRITEME: Document this method brpocock@star-hope.org
	 * @param D0 WRITEME: Document this method brpocock@star-hope.org
	 * @param D1 WRITEME: Document this method brpocock@star-hope.org
	 * @param D2 WRITEME: Document this method brpocock@star-hope.org
	 * @param D0D1 WRITEME: Document this method brpocock@star-hope.org
	 * @param D0D2 WRITEME: Document this method brpocock@star-hope.org
	 * @return WRITEME: Document this method brpocock@star-hope.org
	 */
	private double [] computeIntervals (final double VV0,
			final double VV1, final double VV2, final double D0,
			final double D1, final double D2, final double D0D1,
			final double D0D2) {
		double isect0, isect1;
		if (D0D1 > 0.0f) {
			/* here we know that D0D2<=0.0 */
			/*
			 * that is D0, D1 are on the same side, D2 on the other
			 * or on the plane
			 */
			isect0 = isect (VV2, VV0, D2, D0);
			isect1 = isect (VV2, VV1, D2, D1);
		} else if (D0D2 > 0.0f) {
			/* here we know that d0d1<=0.0 */
			isect0 = isect (VV1, VV0, D1, D0);
			isect1 = isect (VV1, VV2, D1, D2);
		} else if ( ( (D1 * D2) > 0.0f) || (D0 != 0.0f)) {
			/* here we know that d0d1<=0.0 or that D0!=0.0 */
			isect0 = isect (VV0, VV1, D0, D1);
			isect1 = isect (VV0, VV2, D0, D2);
		} else if (D1 != 0.0f) {
			isect0 = isect (VV1, VV0, D1, D0);
			isect1 = isect (VV1, VV2, D1, D2);
		} else if (D2 != 0.0f) {
			isect0 = isect (VV2, VV0, D2, D0);
			isect1 = isect (VV2, VV1, D2, D1);
		} else {
			return null;
		}
		return new double [] { isect0, isect1 };
	}
	
	/**
	 * Determine whether a coordinate is within the triangle
	 * 
	 * @param point a point to be tested
	 * @return true, if the point is within the area of the triangle
	 */
	private boolean contains (final Coord3D point) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented Triangle::contains (brpocock@star-hope.org, Oct 9, 2010)");
		return false;
	}
	
	/**
	 * Determine whether an entire triangle is contained within this
	 * one
	 * 
	 * @param t another triangle
	 * @return true, if all points of (t) are within this triangle
	 */
	private boolean contains (final Triangle t) {
		return contains (t.points [0]) && contains (t.points [1])
				&& contains (t.points [2]);
	}
	
	/**
	 * Test two triangles for collisions using a planar projection
	 * 
	 * @param n1 a point
	 * @param t another triangle
	 * @return true, if they collide
	 */
	private boolean coplanar_tri_tri (final Coord3D n1,
			final Triangle t) {
		short i0, i1;
		/*
		 * first project onto an axis-aligned plane, that maximizes
		 * the area of the triangles, compute indices: i0,i1.
		 */
		final Coord3D A = n1.absolutes ();
		if (A.x > A.y) {
			if (A.x > A.z) {
				i0 = 1; /* A[0] is greatest */
				i1 = 2;
			} else {
				i0 = 0; /* A[2] is greatest */
				i1 = 1;
			}
		} else /* A[0]<=A[1] */
		{
			if (A.z > A.y) {
				i0 = 0; /* A[2] is greatest */
				i1 = 1;
			} else {
				i0 = 0; /* A[1] is greatest */
				i1 = 2;
			}
		}
		
		/*
		 * test all edges of triangle 1 against the edges of triangle
		 * 2
		 */
		return EDGE_AGAINST_TRI_EDGES (points [0], points [1],
				t.points [0], t.points [1], t.points [2], i0, i1)
				|| EDGE_AGAINST_TRI_EDGES (points [1], points [2],
						t.points [0], t.points [1], t.points [2],
						i0, i1)
				|| EDGE_AGAINST_TRI_EDGES (points [2], points [0],
						t.points [0], t.points [1], t.points [2],
						i0, i1) ||
				/*
				 * finally, test if tri1 is totally contained in
				 * tri2 or vice versa
				 */
				this.contains (t) || t.contains (this);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param V0 WRITEME: Document this method brpocock@star-hope.org
	 * @param V1 WRITEME: Document this method brpocock@star-hope.org
	 * @param U0 WRITEME: Document this method brpocock@star-hope.org
	 * @param U1 WRITEME: Document this method brpocock@star-hope.org
	 * @param U2 WRITEME: Document this method brpocock@star-hope.org
	 * @param i0 WRITEME: Document this method brpocock@star-hope.org
	 * @param i1 WRITEME: Document this method brpocock@star-hope.org
	 * @return WRITEME: Document this method brpocock@star-hope.org
	 */
	public boolean EDGE_AGAINST_TRI_EDGES (final Coord3D V0,
			final Coord3D V1, final Coord3D U0, final Coord3D U1,
			final Coord3D U2, final int i0, final int i1) {
		double Ax = 0;
		double Ay = 0;
		switch (i0) {
		default: // shouldn't happen
			assert false : "unreachable";
			break;
		case 0:// x
			Ax = V1.x - V0.x;
			break;
		case 1:// y
			Ax = V1.y - V0.y;
			break;
		case 2:// z
			Ax = V1.z - V0.z;
			break;
		}
		// FIXME: Ay?
		Ay = 0;
		/* test edge U0,U1 against V0,V1 */
		if (EDGE_EDGE_TEST (V0, U0, U1, i0, i1, Ax, Ay)) {
			return true;
		}
		/* test edge U1,U2 against V0,V1 */
		if (EDGE_EDGE_TEST (V0, U1, U2, i0, i1, Ax, Ay)) {
			return true;
		}
		/* test edge U2,U1 against V0,V1 */
		return EDGE_EDGE_TEST (V0, U2, U0, i0, i1, Ax, Ay);
	}
	
	/**
	 * this edge to edge test is based on Franlin Antonio's gem:
	 * "Faster Line Segment Intersection", in Graphics Gems III, pp.
	 * 199-202
	 * 
	 * @param V0 WRITEME: Document this method brpocock@star-hope.org
	 * @param U0 WRITEME: Document this method brpocock@star-hope.org
	 * @param U1 WRITEME: Document this method brpocock@star-hope.org
	 * @param i0 WRITEME: Document this method brpocock@star-hope.org
	 * @param i1 WRITEME: Document this method brpocock@star-hope.org
	 * @param Ax WRITEME: Document this method brpocock@star-hope.org
	 * @param Ay WRITEME: Document this method brpocock@star-hope.org
	 * @return WRITEME: Document this method brpocock@star-hope.org
	 */
	public boolean EDGE_EDGE_TEST (final Coord3D V0, final Coord3D U0,
			final Coord3D U1, final int i0, final int i1,
			final double Ax, final double Ay) {
		double Bx = 0, By = 0, Cx = 0, Cy = 0;
		switch (i0) {
		default: // shouldn't happen
			assert false : "unreachable";
			break;
		case 0: // x
			Bx = U0.x - U1.x;
			Cx = V0.x - U0.x;
			break;
		case 1: // y
			Bx = U0.y - U1.y;
			Cx = V0.y - U0.y;
			break;
		case 2: // z
			Bx = U0.z - U1.z;
			Cx = V0.z - U0.z;
			break;
		}
		switch (i1) {
		default: // shouldn't happen
			assert false : "unreachable";
			break;
		case 0: // x,x
			By = U0.x - U1.x;
			Cy = V0.x - U0.x;
			break;
		case 1: // x,y
			By = U0.y - U1.y;
			Cy = V0.y - U0.y;
			break;
		case 2: // x,z
			By = U0.z - U1.z;
			Cy = V0.z - U0.z;
			break;
		}
		final double f = (Ay * Bx) - (Ax * By);
		final double d = (By * Cx) - (Bx * Cy);
		if ( ( (f > 0) && (d >= 0) && (d <= f))
				|| ( (f < 0) && (d <= 0) && (d >= f))) {
			final double e = (Ax * Cy) - (Ay * Cx);
			if (f > 0) {
				if ( (e >= 0) && (e <= f)) {
					return true;
				}
			} else {
				if ( (e <= 0) && (e >= f)) {
					return true;
				}
			}
		}
		return false;
	}
	
	/**
	 * Get the edges of this triangle
	 * 
	 * @return the edges
	 */
	public Collection <LineSeg3D> getEdges () {
		final List <LineSeg3D> e = new LinkedList <LineSeg3D> ();
		e.add (new LineSeg3D (points [0], points [1]));
		e.add (new LineSeg3D (points [1], points [2]));
		e.add (new LineSeg3D (points [0], points [2]));
		return e;
	}
	
	/**
	 * Get the vertices of the triangle
	 * 
	 * @return the vertices as a Collection
	 */
	public Collection <Coord3D> getVertices () {
		final List <Coord3D> list = new LinkedList <Coord3D> ();
		list.add (points [0]);
		list.add (points [1]);
		list.add (points [2]);
		return list;
	}
	
	/**
	 * Get the vertices of the triangle as an array
	 * 
	 * @return the vertices
	 */
	public Coord3D [] getVerticesArray () {
		return Arrays.copyOf (points, 3);
	}
	
	/**
	 * @param edge a line segment
	 * @return true, if the segment makes up one of the edges of this
	 *         triangle
	 */
	public boolean hasEdge (final LineSeg3D edge) {
		return ( (edge.hasEndpoint (points [0]) ? 1 : 0)
				+ (edge.hasEndpoint (points [1]) ? 1 : 0) + (edge
					.hasEndpoint (points [2]) ? 1 : 0)) > 1;
	}
	
	/**
	 * @param vertex a point
	 * @return true, if “vertex” is one of the vertices of the triangle
	 */
	public boolean hasVertex (final Coord3D vertex) {
		if (null == vertex) {
			return false;
		}
		return vertex.equals (points [0])
				|| vertex.equals (points [1])
				|| vertex.equals (points [2]);
	}
	
	/**
	 * @param t another triangle
	 * @return true, if this triangle in any way intersects the other
	 */
	public boolean intersects (final Triangle t) {
		
		/*
		 * First off, are they the same?
		 */
		if (equals (t)) {
			return true;
		}
		
		Coord3D E1, E2;
		Coord3D N1, N2;
		double d1, d2;
		double du0, du1, du2, dv0, dv1, dv2;
		Coord3D D;
		double isect1[] = { 0, 0 };
		double isect2[] = { 0, 0 };
		double du0du1, du0du2, dv0dv1, dv0dv2;
		int index;
		double vp0, vp1, vp2;
		double up0, up1, up2;
		double b, c, max;
		
		/* compute plane equation of triangle(V0,V1,V2) */
		E1 = t.points [1].subtract (points [0]);
		E2 = t.points [2].subtract (points [0]);
		N1 = E1.crossProduct (E2);
		d1 = -N1.dotProduct (points [0]);
		/* plane equation 1: N1.X+d1=0 */
		
		/*
		 * put U0,U1,U2 into plane equation 1 to compute signed
		 * distances to the plane
		 */
		du0 = N1.dotProduct (t.points [0]) + d1;
		du1 = N1.dotProduct (t.points [1]) + d1;
		du2 = N1.dotProduct (t.points [2]) + d1;
		
		/* coplanarity robustness check */
		if (Triangle.useEpsilonTest) {
			if (Math.abs (du0) < Triangle.epsilon) {
				du0 = 0.0;
			}
			if (Math.abs (du1) < Triangle.epsilon) {
				du1 = 0.0;
			}
			if (Math.abs (du2) < Triangle.epsilon) {
				du2 = 0.0;
			}
		}
		du0du1 = du0 * du1;
		du0du2 = du0 * du2;
		
		if ( (du0du1 > 0) && (du0du2 > 0)) {
			return false; /* no intersection occurs */
		}
		
		/* compute plane of triangle (U0,U1,U2) */
		E1 = t.points [1].subtract (t.points [0]);
		E2 = t.points [2].subtract (t.points [0]);
		N2 = E1.crossProduct (E2);
		d2 = -N2.dotProduct (t.points [0]);
		/* plane equation 2: N2.X+d2=0 */
		
		/* put V0,V1,V2 into plane equation 2 */
		dv0 = N2.dotProduct (points [0]) + d2;
		dv1 = N2.dotProduct (points [1]) + d2;
		dv2 = N2.dotProduct (points [2]) + d2;
		
		if (Triangle.useEpsilonTest) {
			if (Math.abs (dv0) < Triangle.epsilon) {
				dv0 = 0.0;
			}
			if (Math.abs (dv1) < Triangle.epsilon) {
				dv1 = 0.0;
			}
			if (Math.abs (dv2) < Triangle.epsilon) {
				dv2 = 0.0;
			}
		}
		
		dv0dv1 = dv0 * dv1;
		dv0dv2 = dv0 * dv2;
		
		if ( (dv0dv1 > 0.0f) && (dv0dv2 > 0.0f)) {
			return false; /* no intersection occurs */
		}
		
		/* compute direction of intersection line */
		D = N1.crossProduct (N2);
		
		/* compute and index to the largest component of D */
		max = Math.abs (D.getX ());
		index = 0;
		b = Math.abs (D.getY ());
		c = Math.abs (D.getZ ());
		if (b > max) {
			max = b;
			index = 1;
		}
		if (c > max) {
			max = c;
			index = 2;
		}
		
		/* this is the simplified projection onto L */
		switch (index) {
		case 0:
			vp0 = points [0].getX ();
			vp1 = points [1].getX ();
			vp2 = points [2].getX ();
			up0 = t.points [0].getX ();
			up1 = t.points [1].getX ();
			up2 = t.points [2].getX ();
			break;
		case 1:
			vp0 = points [0].getY ();
			vp1 = points [1].getY ();
			vp2 = points [2].getY ();
			up0 = t.points [0].getY ();
			up1 = t.points [1].getY ();
			up2 = t.points [2].getY ();
			break;
		case 2:
			vp0 = points [0].getZ ();
			vp1 = points [1].getZ ();
			vp2 = points [2].getZ ();
			up0 = t.points [0].getZ ();
			up1 = t.points [1].getZ ();
			up2 = t.points [2].getZ ();
			break;
		default:
			throw BugReporter.getReporter ("srv").fatalBug (
					"Unreachable");
		}
		
		/* compute interval for triangle 1 */
		isect1 = computeIntervals (vp0, vp1, vp2, dv0, dv1, dv2,
				dv0dv1, dv0dv2);
		if (null == isect1) {
			return coplanar_tri_tri (N1, t);
		}
		
		/* compute interval for triangle 2 */
		isect2 = computeIntervals (up0, up1, up2, du0, du1, du2,
				du0du1, du0du2);
		if (null == isect2) {
			return coplanar_tri_tri (N1, t);
		}
		
		if (isect1 [0] > isect1 [1]) {
			final double n = isect1 [1];
			isect1 [1] = isect1 [0];
			isect1 [0] = n;
		}
		if (isect2 [0] > isect2 [1]) {
			final double n = isect2 [1];
			isect2 [1] = isect2 [0];
			isect2 [0] = n;
		}
		
		if ( (isect1 [1] < isect2 [0]) || (isect2 [1] < isect1 [0])) {
			return false;
		}
		return true;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param vv1 WRITEME: Document this method brpocock@star-hope.org
	 * @param vv0 WRITEME: Document this method brpocock@star-hope.org
	 * @param d0 WRITEME: Document this method brpocock@star-hope.org
	 * @param d1 WRITEME: Document this method brpocock@star-hope.org
	 * @return WRITEME: Document this method brpocock@star-hope.org
	 */
	private double isect (final double vv1, final double vv0,
			final double d0, final double d1) {
		return vv0 + ( ( (vv1 - vv0) * d0) / (d0 - d1));
	}
	
	/**
	 * @return true, if any two (or all three) vertices of the triangle
	 *         are the same, therefore this is not really a triangle,
	 *         but rather a point or line.
	 */
	public boolean isNotPlane () {
		return points [0].equals (points [1])
				|| points [1].equals (points [2])
				|| points [2].equals (points [0]);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param t WRITEME
	 * @return WRITEME
	 */
	public Collection <? extends Triangle> subtract (final Triangle t) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented Triangle::subtract (brpocock@star-hope.org, Oct 9, 2010)");
		return null;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "Triangle " + points [0].toString () + "-"
				+ points [1].toString () + "-"
				+ points [2].toString ();
	}
	
}
